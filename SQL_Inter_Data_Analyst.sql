--Data 
Select *
From Orders$,Returns$,People$
--Cau 1:Cac mat hang, tong Orders va tong doanh thu 
Select Category,Count(Category) as Number_of_Category,SUM(Sales) as Sales_Total
From Orders$
Group by Category
--Cau 2: Tong so Order cua cac Category
Select [Customer Name],Count(Category) as Number_of_Category,Max(Category) as Loai_hang_dc_yeu_thich
From Orders$
Group by [Customer Name]
--Cau 3:Dich vu Ship duoc su dung nhieu nhat 
Select [Ship Mode] ,COUNT([Ship Mode])
From Orders$
Group by [Ship Mode]
--Cau 4: So ngay ship tieu chuan
Select [Ship Mode],DATEDIFF(DAY,[Order Date],[Ship Date]) as So_ngay_ship_thuc_te,
(Case [Ship Mode]
	When 'Standard Class' THEN 5
	When 'Second Class' Then 3
	When 'First Class' Then 1
	When 'Same Day' Then 0
	Else 'Error' 
End ) as Songaytieuchuan
From Orders$
Order by 2 desc
--Cau 5: Bang nao mua hang nhieu nhat
Select State,Count(State) as So_luong,Max(Category) as Hang_dc_mua_nhieu_nhat,SUM(Sales) as Doanh_thu
From Orders$
Group by State
Order by 2

--Cau 5:Cac KH Return va phan loai theo Category
Select Category, COUNT(Category) as Total
From Orders$
lEFT JOIN Returns$ ON Orders$.[Order ID] = Returns$.[Order ID]
Where Returned = 'Yes'
Group by Category
--Cau 6:Tinh Sales and Profit cua cac bang(State)
Select State ,SUM(Profit)as Profits,SUM(Sales) as Sales, Max(Category) as Hang_Hoa
From Orders$
RIGHT Join Returns$ on Orders$.[Order ID] = Returns$.[Order ID]
Where Returned = 'Yes'
Group by State
Order by 2 desc 
--Cau 7:So KH Returned va san pham duoc Return nhieu nhat 
Select State as Bang, COUNT(Orders$.[Order ID]) as SO_KH,COUNT(Returned) as So_KH_Return,Max(Category) as Max_Return
From Returns$
Right Join Orders$ On Returns$.[Order ID] = Orders$.[Order ID] 
Group by State 
Order by 3 desc