select *
From [Portofilio Project ]..CovidDeaths
where continent is not null
order by 3,4 


--s�lection les donn�es qui on va utiliser 

select location, date, total_cases, new_cases, total_deaths, population
from [Portofilio Project ]..CovidDeaths
where continent is not null
order by 1,2

          --correction des types de donn�es 

-- 1. D'abord, on s'assure que les dates vides sont bien NULL (s�curit�)
UPDATE [Portofilio Project ]..CovidDeaths 
SET date = NULL 
WHERE date = '';

-- 2. Ensuite, on change le type en DATE (ou DATETIME)
ALTER TABLE [Portofilio Project ]..CovidDeaths 
ALTER COLUMN date DATE;

-- A. Nettoyage des donn�es (Remplacer le vide '' par NULL)
UPDATE [Portofilio Project ]..CovidDeaths SET total_cases = NULL WHERE total_cases = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_cases = NULL WHERE new_cases = '';
UPDATE [Portofilio Project ]..CovidDeaths SET total_deaths = NULL WHERE total_deaths = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_deaths = NULL WHERE new_deaths = '';
UPDATE [Portofilio Project ]..CovidDeaths SET population = NULL WHERE population = '';

-- B. Conversion des types en FLOAT
ALTER TABLE [Portofilio Project ]..CovidDeaths ALTER COLUMN total_cases FLOAT;
ALTER TABLE [Portofilio Project ]..CovidDeaths ALTER COLUMN new_cases FLOAT;
ALTER TABLE [Portofilio Project ]..CovidDeaths ALTER COLUMN total_deaths FLOAT;
ALTER TABLE [Portofilio Project ]..CovidDeaths ALTER COLUMN new_deaths FLOAT;
ALTER TABLE [Portofilio Project ]..CovidDeaths ALTER COLUMN population FLOAT;

--Groupe A : Les colonnes "Smoothed" (Moyennes liss�es)
-- 1. Nettoyage (Remplacer le vide par NULL)
UPDATE [Portofilio Project ]..CovidDeaths SET new_cases_smoothed = NULL WHERE new_cases_smoothed = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_deaths_smoothed = NULL WHERE new_deaths_smoothed = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_cases_smoothed_per_million = NULL WHERE new_cases_smoothed_per_million = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_deaths_smoothed_per_million = NULL WHERE new_deaths_smoothed_per_million = '';

--Groupe B : Les colonnes "Per Million" (Statistiques relatives)
-- 1. Nettoyage
UPDATE [Portofilio Project ]..CovidDeaths SET total_cases_per_million = NULL WHERE total_cases_per_million = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_cases_per_million = NULL WHERE new_cases_per_million = '';
UPDATE [Portofilio Project ]..CovidDeaths SET total_deaths_per_million = NULL WHERE total_deaths_per_million = '';
UPDATE [Portofilio Project ]..CovidDeaths SET new_deaths_per_million = NULL WHERE new_deaths_per_million = '';


-- chercher 'deathpourcentage'  total cases vs total deaths(tr�s important)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
order by 1,2

--total cases vs Population 
-- porcentage de population qui on covid 
select location, date, population, total_cases,  (total_cases/population)*100 as percentPopulationInfected
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
order by 1,2

-- les pays avec le pourcentage  les plus haut d'infection comparer de la population 

select location, population, Max(cast(total_cases as float)) as HighestInfection, (Max(cast(total_cases as float)) / population)*100 as percentPopulationInfected
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
GROUP BY  location, population
order by percentPopulationInfected desc


--la population des pays avec les haut nombre des d�c�s

select location, MAX(cast(total_deaths as int)) as Totaldeathcount
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
GROUP BY  location
order by Totaldeathcount desc


--avec continent

select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
GROUP BY continent
order by Totaldeathcount desc

-- continent avec le plus haut nombre de d�c�s par population 

select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
from [Portofilio Project ]..CovidDeaths
where continent is not null
--where location like '%tunisia%'
GROUP BY continent
order by Totaldeathcount desc



--global numbers 

select sum(new_cases) as total_cases, Sum (cast(new_deaths as int)) as total_deaths, 
SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
from [Portofilio Project ]..CovidDeaths
where continent is not null
--Group by date
--where location like '%tunisia%'
order by 1,2


-- 1. Nettoyage de la colonne vac_vaccinartions (Remplacer le vide par NULL)

UPDATE [Portofilio Project ]..CovidVaccinations SET new_vaccinations = NULL WHERE new_vaccinations = '';

--looking at total popultion vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
from [Portofilio Project ]..CovidDeaths dea
Join [Portofilio Project ]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--and vac.new_vaccinations is not null
order by 2,3


--devide the max number people vaccinated to the population 
--( to know the numbers of people vaccinated)

--first we are going to use CTE (common table expression)

with PopvsVac (continent , location , date, population , new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from [Portofilio Project ]..CovidDeaths dea
Join [Portofilio Project ]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--and vac.new_vaccinations is not null
--order by 2,3
)
select *,(RollingPeopleVaccinated/population)*100 as PourcentageVac
from PopvsVac


--TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated;
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date date,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from [Portofilio Project ]..CovidDeaths dea
Join [Portofilio Project ]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--and vac.new_vaccinations is not null
--order by 2,3

select *,(RollingPeopleVaccinated/population)*100 as PourcentageVac
from #PercentPopulationVaccinated



--cerating view to store data for lateer visualizations
DROP View IF EXISTS PercentPopulationVaccinated;

CREATE VIEW PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from [Portofilio Project ]..CovidDeaths dea
Join [Portofilio Project ]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--and vac.new_vaccinations is not null
--order by 2,3

select *
from PercentPopulationVaccinated