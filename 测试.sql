-- 前台查看读者简略信息
SELECT 
    reader_no as '读者证号',
    name as '姓名',
    total_borrowed as '总借阅次数',
    current_borrowed as '当前借阅数量',
    CASE 
        WHEN account_status = 1 THEN '正常'
        ELSE '禁用'
    END as '账户状态'
FROM reader
WHERE name LIKE '张%' OR phone LIKE '13800138004%';




-- 模拟前台为读者张三借阅图书
SET @reader_id = 1; 
SET @book_id = 4;  
SET @staff_id = 1;   
CALL sp_borrow_book(@reader_id, @book_id, @staff_id, 30, @result, @message);
 
-- 查看借阅结果
SELECT @result as '执行结果', @message as '提示信息';
 
-- 验证借阅结果
SELECT 
    b.title as '图书名称',
    br.borrow_time as '借阅时间',
    br.due_time as '应还时间',
    CASE br.status 
        WHEN 1 THEN '借阅中'
        WHEN 2 THEN '已归还'
        WHEN 3 THEN '逾期'
    END as '状态',
    r.name as '读者姓名',
    r.current_borrowed as '当前借阅数量'
FROM borrow_record br
JOIN reader r ON br.reader_id = r.reader_id
JOIN book b ON br.book_id = b.book_id
WHERE br.reader_id = @reader_id AND br.status = 1;
-- 查看图书库存变化
SELECT 
    title as '图书名称',
    available_copies as '可借数量',
    borrow_times as '借阅次数'
FROM book 
WHERE book_id = @book_id;

 
 


-- 先查看张三当前的借阅记录
SELECT 
    record_id as '记录ID',
    b.title as '图书名称',
    borrow_time as '借阅时间',
    due_time as '应还时间'
FROM borrow_record br
JOIN book b ON br.book_id = b.book_id
WHERE br.reader_id = 1 AND br.status = 1
LIMIT 1;
 
-- 假设记录ID为1（三国演义）
SET @record_id = 1;
SET @staff_id = 1;
-- 执行归还操作
CALL sp_return_book(@record_id, @staff_id, @result, @message, @fine_amount);
-- 查看归还结果
SELECT @result as '执行结果', @message as '提示信息', @fine_amount as '罚款金额';
-- 查看归还后的记录
SELECT 
    b.title as '图书名称',
    br.borrow_time as '借阅时间',
    br.return_time as '归还时间',
    br.fine_amount as '罚款金额'
FROM borrow_record br
JOIN book b ON br.book_id = b.book_id
WHERE br.record_id = @record_id;
-- 查看图书库存恢复情况
SELECT 
    title as '图书名称',
    available_copies as '可借数量'
FROM book 
WHERE book_id = (SELECT book_id FROM borrow_record WHERE record_id = @record_id);
  



-- 查看读者的未支付罚款
SELECT 
    fr.fine_id as '罚款ID',
    r.name as '读者姓名',
    fr.amount as '罚款金额',
    fr.reason as '罚款原因',
    CASE fr.payment_status 
        WHEN 0 THEN '未支付'
        WHEN 1 THEN '已支付'
    END as '支付状态',
    b.title as '相关图书'
FROM fine_record fr
JOIN reader r ON fr.reader_id = r.reader_id
JOIN borrow_record br ON fr.record_id = br.record_id
JOIN book b ON br.book_id = b.book_id
WHERE fr.payment_status = 0;
-- 收取罚款（假设罚款ID为1）
UPDATE fine_record 
SET payment_status = 1, 
    payment_time = NOW(),
    staff_id = 1
WHERE fine_id = 1;
-- 记录收入
INSERT INTO income_record (reader_id, amount, type, description, staff_id)
SELECT 
    reader_id,
    amount,
    '罚款',
    CONCAT('逾期罚款-', reason),
    1
FROM fine_record 
WHERE fine_id = 1;
-- 验证罚款支付
SELECT * FROM fine_record WHERE fine_id = 1;
SELECT * FROM income_record WHERE reader_id = (SELECT reader_id FROM fine_record WHERE fine_id = 1);



-- 2.1.2 按作者搜索
SELECT 
    title as '书名',
    author as '作者',
    publisher as '出版社',
    category_name as '分类',
    borrow_times as '借阅次数'
FROM v_book_search
WHERE author LIKE '%东野圭吾%'
ORDER BY borrow_times DESC;
 
 


-- 假设读者张三（ID=1）查询自己的记录
-- 2.2.1 查看所有借阅记录
SELECT 
    b.title as '图书名称',
    br.borrow_time as '借阅时间',
    br.due_time as '应还时间',
    br.return_time as '归还时间',
    CASE br.status 
        WHEN 1 THEN '借阅中'
        WHEN 2 THEN '已归还'
        WHEN 3 THEN '逾期'
    END as '状态',
    br.fine_amount as '罚款金额'
FROM borrow_record br
JOIN book b ON br.book_id = b.book_id
WHERE br.reader_id = 1
ORDER BY br.borrow_time DESC;
 
 
 

INSERT INTO book (
    isbn, title, author, publisher, publish_date, 
    category_id, total_copies, available_copies, 
    price, location, description, status
) VALUES (
    '978751', 
    '平凡的世界', 
    '路遥', 
    '北京十月文艺出版社', 
    '2012-03-01',
    1,  -- 文学类
    6, 6, 
    79.80, 
    'A区-文学架-04',
    '中国当代文学经典之作，获得茅盾文学奖',
    1
);
 
-- 3.1.2 查询图书信息
SELECT 
    book_id as '图书ID',
    title as '书名',
    author as '作者',
    publisher as '出版社',
    total_copies as '总数量',
    available_copies as '可借数量',
    borrow_times as '借阅次数',
    CASE status 
        WHEN 1 THEN '可借'
        WHEN 0 THEN '不可借'
    END as '状态'
FROM book
WHERE author LIKE '%路遥%' OR title LIKE '%平凡%';

-- 3.1.3 更新图书信息
UPDATE book 
SET 
    total_copies = 8,
    available_copies = 8,
    price = 88.00,
    updated_at = NOW()
WHERE title = '平凡的世界';
 
-- 3.1.4 删除图书（标记为不可借）
UPDATE book 
SET 
    status = 0,
    updated_at = NOW()
WHERE title = '葫芦娃' AND available_copies = 0;


-- 3.2.2 按分类统计借阅情况
SELECT 
    c.category_name as '图书分类',
    COUNT(br.record_id) as '借阅次数',
    COUNT(DISTINCT br.reader_id) as '借阅人数',
    SUM(b.price) as '图书总价值'
FROM borrow_record br
JOIN book b ON br.book_id = b.book_id
JOIN book_category c ON b.category_id = c.category_id
WHERE br.borrow_time >= '2024-08-01'
GROUP BY c.category_name
ORDER BY COUNT(br.record_id) DESC;


 
-- 3.2.4 图书馆收入统计
SELECT * FROM v_library_income;
 
-- 详细收入查询
SELECT 
    DATE(ir.payment_time) as '收入日期',
    ir.type as '收入类型',
    r.name as '读者姓名',
    ir.amount as '金额',
    ir.description as '说明',
    s.name as '操作员'
FROM income_record ir
LEFT JOIN reader r ON ir.reader_id = r.reader_id
LEFT JOIN library_staff s ON ir.staff_id = s.staff_id
ORDER BY ir.payment_time DESC;

 


-- 3.3.3 根据身份证号查询
SELECT 
    r.*,
    GROUP_CONCAT(DISTINCT b.title ORDER BY br.borrow_time DESC) as '最近借阅图书'
FROM reader r
LEFT JOIN borrow_record br ON r.reader_id = br.reader_id
LEFT JOIN book b ON br.book_id = b.book_id
WHERE r.id_card = '110101199001011234'
GROUP BY r.reader_id;
 


-- 3.4.1 查询员工信息
SELECT 
    staff_no as '员工编号',
    name as '姓名',
    position as '职位',
    phone as '联系电话',
    CASE status 
        WHEN 1 THEN '在职'
        WHEN 0 THEN '离职'
    END as '工作状态',
    permissions as '权限',
    created_at as '入职时间'
FROM library_staff
ORDER BY position, staff_no;
 
-- 3.4.2 修改员工信息
-- 修改联系方式
UPDATE library_staff 
SET phone = '13800138111'
WHERE staff_no = 'STAFF001';
 
-- 修改权限
UPDATE library_staff 
SET permissions = 'borrow,return,fee,query'
WHERE staff_no = 'STAFF003';
 
-- 修改职位
UPDATE library_staff 
SET position = '高级管理员'
WHERE staff_no = 'STAFF002';
 
-- 验证修改结果
SELECT * FROM library_staff WHERE staff_no IN ('STAFF001', 'STAFF002', 'STAFF003');
 


-- 3.5.3 更新分类信息
UPDATE book_category 
SET description = '包含深度学习、机器学习等'
WHERE category_name = '人工智能';
 
-- 3.5.4 删除分类（需要先删除相关图书或转移分类）
-- 首先检查该分类下是否有图书
SELECT COUNT(*) as '图书数量' 
FROM book 
WHERE category_id = (SELECT category_id FROM book_category WHERE category_name = '秘籍类');
 
-- 如果没有图书，可以删除
DELETE FROM book_category WHERE category_name = '秘籍类';
 
-- 查看所有分类
SELECT * FROM book_category ORDER BY parent_id, category_name;
 


-- 4.1.1 读者登录验证
SELECT 
    reader_id,
    name,
    reader_no,
    CASE account_status 
        WHEN 1 THEN '登录成功'
        ELSE '账户已被禁用'
    END as '登录结果'
FROM reader 
WHERE reader_no = 'R2024001' 
  AND password = '4QrcOUm6Wau+VuBX8g+IPg=='  -- 密码是123456
LIMIT 1;
 
-- 4.1.2 员工登录验证
SELECT 
    staff_id,
    name,
    staff_no,
    position,
    permissions,
    CASE status 
        WHEN 1 THEN '登录成功'
        ELSE '账户异常'
    END as '登录结果'
FROM library_staff 
WHERE staff_no = 'STAFF001' 
  AND password = '4QrcOUm6Wau+VuBX8g+IPg=='
LIMIT 1;
 


-- 检查员工权限
SELECT 
    name as '员工姓名',
    position as '职位',
    permissions as '权限列表',
    CASE 
        WHEN permissions LIKE '%all%' THEN '拥有所有权限'
        WHEN permissions LIKE '%borrow%' THEN '可以办理借阅'
        WHEN permissions LIKE '%return%' THEN '可以办理归还'
        WHEN permissions LIKE '%fee%' THEN '可以收费'
        ELSE '基础权限'
    END as '权限说明'
FROM library_staff
ORDER BY position;
 

-- 4.3.1 查看库存为0的图书
SELECT * FROM v_zero_stock_books;

-- 4.3.2 查看需要补货的图书
SELECT 
    b.title as '图书名称',
    b.author as '作者',
    b.total_copies as '总数量',
    b.available_copies as '可借数量',
    b.borrow_times as '借阅次数',
    b.borrow_times / GREATEST(b.total_copies, 1) as '流通率',
    CASE 
        WHEN b.available_copies = 0 THEN '急需补货'
        WHEN b.available_copies <= b.total_copies * 0.2 THEN '建议补货'
        ELSE '库存正常'
    END as '补货建议'
FROM book b
WHERE b.total_copies > 0
ORDER BY b.borrow_times DESC, b.available_copies ASC;
 
 
-- 4.4.1 禁用/启用读者账户
-- 禁用账户
UPDATE reader 
SET account_status = 0
WHERE name = '王五';
 
-- 启用账户
UPDATE reader 
SET account_status = 1
WHERE name = '王五';
 
-- 查看账户状态
SELECT 
    name,
    reader_no,
    phone,
    CASE account_status 
        WHEN 1 THEN '正常'
        WHEN 0 THEN '禁用'
    END as '账户状态',
    borrow_limit as '借阅上限',
    borrow_days as '借阅天数'
FROM reader
ORDER BY account_status DESC, name;

-- 4.4.2 设置读者借阅权限
UPDATE reader 
SET 
    borrow_limit = 8,      -- 增加借阅上限
    borrow_days = 45       -- 延长借阅天数
WHERE name = '张三';
 
-- 验证权限设置
SELECT 
    name as '读者姓名',
    borrow_limit as '最大借阅数量',
    borrow_days as '最长借阅天数',
    current_borrowed as '当前借阅数',
    account_status as '账户状态'
FROM reader
WHERE name = '张三';


-- 查看最近的系统操作日志
SELECT 
    log_id as '日志ID',
    CASE user_type 
        WHEN 'staff' THEN '员工'
        WHEN 'reader' THEN '读者'
        ELSE user_type 
    END as '用户类型',
    action as '操作类型',
    target_type as '操作对象',
    details as '操作详情',
    ip_address as 'IP地址',
    created_at as '操作时间'
FROM system_log
ORDER BY created_at DESC
LIMIT 10;
 


-- 今日借阅统计
SELECT 
    '今日借阅' as '统计项',
    COUNT(*) as '数量',
    COUNT(DISTINCT reader_id) as '借阅人数',
    SUM(CASE WHEN br.status = 1 THEN 1 ELSE 0 END) as '新增借阅'
FROM borrow_record br
WHERE DATE(br.borrow_time) = CURDATE();
-- 今日归还统计
SELECT 
    '今日归还' as '统计项',
    COUNT(*) as '数量',
    SUM(br.fine_amount) as '产生罚款',
    SUM(CASE WHEN br.fine_amount > 0 THEN 1 ELSE 0 END) as '逾期归还数'
FROM borrow_record br
WHERE DATE(br.return_time) = CURDATE();
 

-- 测试读者借阅数量超限
SET @test_reader = 4;  -- 赵六，当前借阅0本
SET @test_book1 = 1;   -- 三国演义
SET @test_book2 = 2;   -- Java编程思想
SET @test_book3 = 3;   -- 活着
SET @test_book4 = 4;   -- 白夜行
SET @test_book5 = 5;   -- 解忧杂货店
SET @test_book6 = 6;   -- Python编程
 
-- 连续借阅测试
CALL sp_borrow_book(@test_reader, @test_book1, 1, 30, @result1, @message1);
SELECT @result1 as '第一次借阅结果', @message1 as '提示信息';
 
CALL sp_borrow_book(@test_reader, @test_book2, 1, 30, @result2, @message2);
SELECT @result2 as '第二次借阅结果', @message2 as '提示信息';
 
CALL sp_borrow_book(@test_reader, @test_book3, 1, 30, @result3, @message3);
SELECT @result3 as '第三次借阅结果', @message3 as '提示信息';
 
CALL sp_borrow_book(@test_reader, @test_book4, 1, 30, @result4, @message4);
SELECT @result4 as '第四次借阅结果', @message4 as '提示信息';
 
CALL sp_borrow_book(@test_reader, @test_book5, 1, 30, @result5, @message5);
SELECT @result5 as '第五次借阅结果', @message5 as '提示信息';
 
-- 测试第六次借阅（应该失败）
CALL sp_borrow_book(@test_reader, @test_book6, 1, 30, @result6, @message6);
SELECT @result6 as '第六次借阅结果', @message6 as '提示信息';


-- 测试借阅库存为0的图书
-- 首先查看葫芦娃的库存
SELECT 
    title as '图书名称',
    total_copies as '总数量',
    available_copies as '可借数量',
    status as '状态'
FROM book 
WHERE title = '葫芦娃';
 
-- 尝试借阅
CALL sp_borrow_book(1, 7, 1, 30, @result7, @message7);  -- 葫芦娃的book_id是7
SELECT @result7 as '借阅结果', @message7 as '提示信息';



-- 创建一条逾期的借阅记录
INSERT INTO borrow_record (
    reader_id, book_id, borrow_time, due_time, borrow_staff_id, status
) VALUES (
    4,  -- 赵六
    6,  -- Python编程
    '2024-07-01 10:00:00',
    '2024-07-31 10:00:00',
    1,
    3  -- 逾期状态
);
 
-- 查看逾期记录
SELECT 
    r.name as '读者姓名',
    b.title as '图书名称',
    br.borrow_time as '借阅时间',
    br.due_time as '应还时间',
    DATEDIFF(NOW(), br.due_time) as '逾期天数',
    CASE br.status 
        WHEN 3 THEN '逾期'
        ELSE '其他'
    END as '状态'
FROM borrow_record br
JOIN reader r ON br.reader_id = r.reader_id
JOIN book b ON br.book_id = b.book_id
WHERE br.status = 3;
 
