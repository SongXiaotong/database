-- 601 human traffic of stadium
-- 方法一：使用同一张表
select * from stadium
where (id in
(select id from stadium where people >= 100)
and id+1 in
(select id from stadium where people >= 100)
and id+2 in
(select id from stadium where people >= 100))
OR
(id-1 in
(select id from stadium where people >= 100)
and id in
(select id from stadium where people >= 100)
and id+1 in
(select id from stadium where people >= 100))
OR
(id-2 in
(select id from stadium where people >= 100)
and id-1 in
(select id from stadium where people >= 100)
and id in
(select id from stadium where people >= 100));
--方法二：使用三张表
select distinct t1.* from stadium as t1, stadium as t2, stadium as t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and (
    t1.id = t2.id-1 and t1.id = t3.id-2
    or t1.id = t2.id+1 and t1.id = t3.id-1
    or t1.id = t2.id+1 and t1.id = t3.id+2
)
order by t1.id asc;