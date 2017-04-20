--查询Users表
SELECT TOP 1 UserId,UserName,Password,Type,LoginTime,Department 
FROM Users
WHERE UserName = 'zzh' AND Password = 'zzh'; 

--查询配件信息
SELECT C.PartId,C.Num,C.PartName,S.Name,C.InTime,C.Quantity,C.UnitPrice
FROM CarParts AS C INNER JOIN Supplies AS S
ON C.FromDepartId = S.Id;

--往配件表中添加数据
INSERT INTO CarParts(Num,PartName,FromDepartId,InTime,Quantity,UnitPrice)
VALUES('P004','后视镜',1,'2000-11-11',100,'500');

--查询配件信息添加Id限制条件
SELECT C.PartId,C.Num,C.PartName,S.Name,C.InTime,C.Quantity,C.UnitPrice
FROM CarParts AS C INNER JOIN Supplies AS S
ON C.FromDepartId = S.Id
WHERE PartId = 1;

--更改配件信息表内容
UPDATE CarParts SET Num='P000',PartName='kkk',FromDepartId = 2,InTime='2212-12-12',Quantity='11',UnitPrice='33'
WHERE PartId = 8;