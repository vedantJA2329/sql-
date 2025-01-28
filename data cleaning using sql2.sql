use world_layoffs;
select * from layoffs;
-- 1.remove duplicates
-- 2.standardize the data
-- 3. null values or blank values
-- 4. remove any columns
 create table layoffs_staging like layoffs;
 select * from layoffs_staging;
 insert layoffs_staging select * from layoffs;
 select * from layoffs_staging;
 select *,row_number() over(partition by company, industry,total_laid_off,percentage_laid_off,
 `date`) as row_num from layoffs_staging;
 with duplicate_cte as
 (select*,row_number() over(
 partition by company,location, industry,total_laid_off,percentage_laid_off,
 `date`,stage,country,funds_raised_millions)as row_num from layoffs_staging)
 select * from duplicate_cte where row_num>1;
 
 delete from duplicate_cte where row_num>1;
 
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
insert into layoffs_staging2 select *,row_number() over(partition by company, industry,total_laid_off,percentage_laid_off,
 `date`) as row_num from layoffs_staging;
 select * from layoffs_staging2 where row_num>1;
 SET SQL_SAFE_UPDATES = 0;
 delete from layoffs_staging2 where row_num>1;

-- standardizing data
select company,trim(company) from layoffs_staging2;
update layoffs_staging2 set company=trim(company);
select distinct(industry) from layoffs_staging2 order by 1;
update layoffs_staging2 set industry='crypto' where industry like 'crypto%';
select distinct country,trim(trailing '.' from country) from layoffs_staging2 order by 1;
update layoffs_staging2 set country = trim(trailing '.' from country) where country like 'united states%';
UPDATE layoffs_staging2 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging2 MODIFY COLUMN `date` DATE;
select * from layoffs_staging2 where industry is null or industry='';
select * from layoffs_staging2 where company='Airbnb';
select * from layoffs_staging2 t1 join layoffs_staging t2 on t1.company=t2.company and 
t1.location=t2.location where (t1.industry is null or t1.industry='') and 
t2.industry is not null;
update layoffs_staging2 t1 join layoffs_staging t2 on t1.company=t2.company set t1.industry = t2.industry where
 (t1.industry is null or t1.industry='') and t2.industry is not null;
 alter table layoffs_staging2 drop column row_num;