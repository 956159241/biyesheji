--��ѯUsers��
SELECT TOP 1 UserId,UserName,Password,Type,LoginTime,Department 
FROM Users
WHERE UserName = 'zzh' AND Password = 'zzh'; 

--��ѯ�����Ϣ
SELECT C.PartId,C.Num,C.PartName,S.Name,C.InTime,C.Quantity,C.UnitPrice
FROM CarParts AS C INNER JOIN Supplies AS S
ON C.FromDepartId = S.Id;

--����������������
INSERT INTO CarParts(Num,PartName,FromDepartId,InTime,Quantity,UnitPrice)
VALUES('P004','���Ӿ�',1,'2000-11-11',100,'500');

--��ѯ�����Ϣ���Id��������
SELECT C.PartId,C.Num,C.PartName,S.Name,C.InTime,C.Quantity,C.UnitPrice
FROM CarParts AS C INNER JOIN Supplies AS S
ON C.FromDepartId = S.Id
WHERE PartId = 1;

--���������Ϣ������
UPDATE CarParts SET Num='P000',PartName='kkk',FromDepartId = 2,InTime='2212-12-12',Quantity='11',UnitPrice='33'
WHERE PartId = 8;