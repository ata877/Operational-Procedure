USE [TreaterLog]
GO

/****** Object:  View [dbo].[vResinActualvsTheory]    Script Date: 16/09/2022 4:24:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

































--ALTER view [dbo].[vResinActualvsTheory]
--as
SELECT 
--	  ph.[logID],
--      ph.[ShopOrderID],
      ph.[ShopOrderNo],
      ph.[ColourName],
      ph.[Item],
      ph.[SheetSize],
	  ti.gsm,
--      ph.[SheetLength],
--      ph.[SheetWidth],
      ph.[MinOfEventStart] as 'Start',
      ph.[MaxOfEventEnd] as 'Stop',
	  DATEADD(wk, DATEDIFF(wk,0,ph.[MinOfEventStart]), 0) as StartWeek,
 --     ph.[MaxOfQuantity_Ordered],
--      ph.[SumOfQuantity_Supplied],
--      ph.[WetTreatedWeight2],
--      ph.[RowNum],
--      ph.[Complete],
--      ph.[LabelPrintingComplete],
      ph.[SumOfSheets] as 'Pallet Sheets',
	  so.qty as 'Wet End Uf Actual',
	  tb.BCHLD as 'Wet End Resin Item',
	  tb1.BQREQ,
	  tb2.bqreq,
	  tb1.bqreq*tb2.bqreq*ph.sumofsheets as 'Wet End UF Theory',
	  so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets) as 'Wet End UF Difference',
	  so1.qty as 'Wet End Mf Actual',
	  tb3.bqreq*tb4.bqreq*ph.sumofsheets as 'Wet End MF Theory',
	  (so1.qty)-(tb3.bqreq*tb4.bqreq*ph.sumofsheets) as 'Wet End MF Difference',
	  (tb1.bqreq*tb2.bqreq*ph.sumofsheets)+(tb3.bqreq*tb4.bqreq*ph.sumofsheets) as 'Wet End Total Theory',
	  (so.qty)+(so1.qty) as 'Wet End Total Actual',
	  (so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))+(so1.qty-(tb3.bqreq*tb4.bqreq*ph.sumofsheets)) as 'Wet End Total Difference',
	  (so.qty)/(ph.[SumOfSheets]) as 'Quantity of Wet End Uf Actual per sheet',
	  (tb1.bqreq*tb2.bqreq*ph.sumofsheets)/(ph.[SumOfSheets]) as 'Quantity of Wet End UF Theory per sheet',
	  (so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]) as 'Quantity of Wet End UF Difference per sheet',
	  (so1.qty)/(ph.[SumOfSheets])  as 'Quantity of Wet End Mf Actual per sheet',
	  (tb3.bqreq*tb4.bqreq*ph.sumofsheets)/(ph.[SumOfSheets]) as 'Quantity of Wet End MF Theory per sheet',
	  (so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]) as 'Quantity of Wet End MF Difference per sheet',
	  ((tb1.bqreq*tb2.bqreq*ph.sumofsheets)+(tb3.bqreq*tb4.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]) as 'Quantity of Wet End Total Theory per sheet',
	  (((tb1.bqreq*tb2.bqreq*ph.sumofsheets)+(tb3.bqreq*tb4.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]))/(ti.gsm) as 'Quantity of Wet End Total Theory per sheet per GSM',
	  ((so.qty)+(so1.qty))/(ph.[SumOfSheets]) as 'Quantity of Wet End Total Actual per sheet',
	  ((so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))+(so1.qty-(tb3.bqreq*tb4.bqreq*ph.sumofsheets)))/(ph.[SumOfSheets]) as 'Quantity of Wet End Total Difference per sheet',
	  ((so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))+(so1.qty-(tb3.bqreq*tb4.bqreq*ph.sumofsheets)))/(ph.[SumOfSheets])/(((tb1.bqreq*tb2.bqreq*ph.sumofsheets)+(tb3.bqreq*tb4.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]))*100 as 'Percentage of Wet End Total Difference per sheet',
	  (so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))+(so1.qty-(tb3.bqreq*tb4.bqreq*ph.sumofsheets))/(ti.gsm) as 'Quantity of Wet End Total Difference per GSM',
	  (((so.qty-(tb1.bqreq*tb2.bqreq*ph.sumofsheets))+(so1.qty-(tb3.bqreq*tb4.bqreq*ph.sumofsheets)))/(ph.[SumOfSheets]))/(ti.gsm) as 'Quantity of Wet End Total Difference per sheet per GSM',
	  So2.qty as 'Centre Mf Actual',
	  Tb5.BCHLD as 'Centre Resin Item',
	  Tb6.bqreq*tb7.bqreq*ph.sumofsheets as 'Centre MF Theory',
	  So2.qty-(Tb6.bqreq*tb7.bqreq*ph.sumofsheets) as 'Centre MF Difference',
	  (So2.qty)/(ph.[SumOfSheets]) as 'Quantity of Centre Mf Actual per sheet',
	  (Tb6.bqreq*tb7.bqreq*ph.sumofsheets)/(ph.[SumOfSheets]) as 'Quantity of Centre MF Theory per sheet',
	  ((Tb6.bqreq*tb7.bqreq*ph.sumofsheets)/(ph.[SumOfSheets]))/(ti.gsm) as 'Quantity of Centre MF Theory per sheet per GSM',
	  (So2.qty-(Tb6.bqreq*tb7.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]) as 'Quantity of Centre MF Difference per sheet',
	   ((So2.qty-(Tb6.bqreq*tb7.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]))/((Tb6.bqreq*tb7.bqreq*ph.sumofsheets)/(ph.[SumOfSheets]))*100 as 'Percentage of Centre MF Difference per sheet',
	  (So2.qty-(Tb6.bqreq*tb7.bqreq*ph.sumofsheets))/(ti.gsm) as 'Quantity of Centre MF Difference per GSM',
	  ((So2.qty-(Tb6.bqreq*tb7.bqreq*ph.sumofsheets))/(ph.[SumOfSheets]))/(ti.gsm) as 'Quantity of Centre MF Difference per sheet per GSM',
	  rr.[QAL] as 'Wet Resin Item QAL',
     rr.[Section] as 'Wet Resin Item Section',
	  rr1.[QAL] as 'Centre Resin Item QAL',
    rr1.[Section] as 'Centre Resin Item Section'
	  
  FROM [dbo].[vPalletLabelHistory] ph
  inner join vtreateritems ti on ph.item=ti.iprod
  inner join vshoporderitems so on so.ShopOrderNo=ph.shoporderno and so.description = 'UF701307 Wet End UF'
--  inner join vtreaterbom tb on ph.item=tb.BPROD and tb.BSEQ=2
  inner join PressLogDB.dbo.tblBOM tb on ph.item=tb.BPROD and tb.BSEQ=2 and ph.[MinOfEventStart] between tb.StartDate and tb.EndDate 
  --  inner join  vtreaterbom tb1 on ph.item = tb1.BPROD and tb1.bseq=2 
  inner join PressLogDB.dbo.tblBOM tb1 on ph.item=tb1.BPROD and tb1.BSEQ=2 and ph.[MinOfEventStart] between tb1.StartDate and tb1.EndDate 
--  inner join vtreaterbom tb2 on tb.BCHLD = tb2.bprod and tb2.bchld = '10002731'
inner join PressLogDB.dbo.tblBOM tb2 on tb.BCHLD=tb2.BPROD and tb2.bchld= '10002731' and ph.[MinOfEventStart] between tb2.StartDate and tb2.EndDate 
  inner join vshoporderitems so1 on so1.ShopOrderNo=ph.shoporderno and so1.description = 'MF700360 Wet End MF'  
--  inner join  vtreaterbom tb3 on ph.item = tb3.BPROD and tb3.bseq=2
inner join PressLogDB.dbo.tblBOM tb3 on ph.item=tb3.BPROD and tb3.BSEQ=2 and ph.[MinOfEventStart] between tb3.StartDate and tb3.EndDate 
--  inner join vtreaterbom tb4 on tb.BCHLD = tb4.bprod and tb4.bchld = '10003985'
inner join PressLogDB.dbo.tblBOM tb4 on tb.BCHLD=tb4.BPROD and tb4.bchld= '10003985' and ph.[MinOfEventStart] between tb4.StartDate and tb4.EndDate 
  inner join vshoporderitems so2 on so2.ShopOrderNo=ph.shoporderno and so2.description = 'MF700360 Centre MF'
--  inner join vtreaterbom tb5 on ph.item=tb5.BPROD and tb5.BSEQ=3
inner join PressLogDB.dbo.tblBOM tb5 on ph.item=tb5.BPROD and tb5.BSEQ=3 and ph.[MinOfEventStart] between tb5.StartDate and tb5.EndDate 
-- inner join  vtreaterbom tb6 on ph.item = tb6.BPROD and tb6.bseq=3
inner join PressLogDB.dbo.tblBOM tb6 on ph.item=tb6.BPROD and tb6.BSEQ=3  and ph.[MinOfEventStart] between tb6.StartDate and tb6.EndDate 
--  inner join vtreaterbom tb7 on tb5.BCHLD = tb7.bprod and tb7.bchld = '10003985'
inner join PressLogDB.dbo.tblBOM tb7 on tb5.BCHLD=tb7.BPROD and tb7.bchld= '10003985' and ph.[MinOfEventStart] between tb7.StartDate and tb7.EndDate 
  inner join [dbo].[ResinRecipe] rr on tb.bchld = rr.item and rr.CurrentVersion = 1
 inner join [dbo].[ResinRecipe] rr1 on tb5.bchld = rr1.item and rr1.CurrentVersion = 1
 
 where ph.[MinOfEventStart]>'01-jan-2022' 
   
  
GO

