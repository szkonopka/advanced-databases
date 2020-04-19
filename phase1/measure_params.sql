set timing off
set termout off
set autotrace off

variable salesOutletId number
variable firstSalesOutletId number
variable sectSalesOutletId number
variable weekId number
variable generationName varchar2(30)
variable outlet_id number
variable year number
variable change float
variable quarter varchar2(2)
variable perc_discount number

exec :salesOutletId := 3
exec :firstSalesOutletId := 2
exec :sectSalesOutletId := 3
exec :weekId := 14
exec :generationName := 'Baby Boomers'
exec :outlet_id := 3
exec :year := 2019
exec :change := 0.05
exec :quarter := 2
exec :perc_discount := 5

set timing on
set termout on
set autotrace traceonly statistics
