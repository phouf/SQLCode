-- Zak�zky, kter� maj� alespo� jednu neobjenanou polo�ku
select * from ZAKAZKA z where z.ID in (select distinct(p.ZAK_ID) FROM ZAKAZKA_POL p where p.OBV is null);

-- P�ehled zak�zek
select z.ID, z.DATUM, z.ACCNT_NAME, 
case z.STAV
  when 0 then 'Otev�en�'
  when 1 then 'Realizovan�'
  when 2 then 'Odm�tnut�'
end as STAV,
z.LIC,
z.MNT   
from ZAKAZKA z where z.ID = 87;

--
SELECT * FROM ZAKAZKA_POL z where lower(z.HOLDER_EMAIL) containing 'kalibra';

-- CTE (Common Table Exprssions)
with CTE_ZPOL as (
select p.ZAK_ID, sum(p.C_NET_MENA) as CNET, sum(p.C_END_EUR) as CEUEUR, sum(p.C_END_CZK) as CEUCZK from ZAKAZKA_POL p group by p.ZAK_ID)
select z.ID, z.DATUM, z.ACCNT_NAME, z.STAV, c.CNET, c.CEUEUR, c.CEUCZK 
from ZAKAZKA z, CTE_ZPOL c
where c.ZAK_ID = z.ID;

--CTE w case
with CTE_ZPOL as (
select p.ZAK_ID, sum(p.C_NET_MENA) as CNET, sum(p.C_END_EUR) as CEUEUR, sum(p.C_END_CZK) as CEUCZK from ZAKAZKA_POL p group by p.ZAK_ID)
select z.ID, z.DATUM, z.ACCNT_NAME,
case z.STAV
  when 0 then 'Otev�en�'
  when 1 then 'Realizovan�'
  when 2 then 'Odm�tnut�'
end as STAV, 
c.CNET, c.CEUEUR, c.CEUCZK 
from ZAKAZKA z, CTE_ZPOL c
where c.ZAK_ID = z.ID;
