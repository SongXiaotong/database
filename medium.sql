-- 177 Nth highest salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N=N-1;
    RETURN (
      select salary as getNthHighestSalar
      from employee
      group by salary desc
      limit 1 offset N
  );
END

-- 178 rank scores
-- 定义变量解法
select Score, Rank from (
    select Score, @curRank := @curRank + IF(@prevScore = Score, 0, 1) as Rank, @prevScore := Score 
    from Scores as s, (select @curRank := 0) as r, (select @prevScore := NULL) as p
    order by Score DESC
) as t;
-- 级联解法
select s1.Score as Score, count(s2.Score) as Rank 
from Scores as s1 
left join (
    select distinct Score from Scores
    ) as s2
on s1.Score <= s2.Score 
group by s1.id 
order by s1.Score desc;


-- 180 consecutive numbers 不要使用连等于
select distinct l1.num as ConsecutiveNums
from Logs as l1, logs as l2, logs as l3
where l1.id = l2.id-1 and l2.id = l3.id-1 and l1.num = l2.num and l2.num = l3.num;

-- 184 department highest salary max只检索一个结果
select department.name as Department, employee.name as Employee, employee.Salary
from department
inner join employee
on department.id = employee.departmentid
where (employee.departmentid, employee.salary) in
(
    select employee.departmentid, max(employee.salary)
    from employee
    group by employee.departmentid
);

-- 626 exchange seats coalesce表示直到选择一个非空值
select s1.id as id, coalesce(s2.student, s1.student) as student 
from seat as s1
left join seat as s2
on ((s1.id = s2.id-1 and s1.id % 2 = 1) or (s1.id = s2.id+1 and s1.id % 2 = 0))
order by s1.id;