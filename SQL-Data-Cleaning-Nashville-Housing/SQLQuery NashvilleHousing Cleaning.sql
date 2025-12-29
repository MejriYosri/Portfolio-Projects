select *
from [Portofilio Project ]..NashvilleHousing

			-- Standardize date format 

SET LANGUAGE English;

select SaleDate
from [Portofilio Project ]..NashvilleHousing

ALTER TABLE [Portofilio Project]..NashvilleHousing
ADD SaleDateConverted DATE;

UPDATE [Portofilio Project]..NashvilleHousing
SET SaleDateConverted = TRY_CONVERT(date, SaleDate, 107);


  SELECT 
    SaleDate,
    SaleDateConverted
FROM [Portofilio Project]..NashvilleHousing

			--Populate Property Adress Data

select*
from [Portofilio Project ]..NashvilleHousing
-- WHERE PropertyAddress IS NULL
order by ParcelID

--"When analyzing the data, we noticed that some ParcelID values are duplicated, 
--and the same issue occurs with PropertyAddress when the data is ordered by ParcelID
--but the UniqueID diffirent"

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portofilio Project ]..NashvilleHousing a
JOIN [Portofilio Project ]..NashvilleHousing b
    on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID] -- "<> it means not equal"
where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portofilio Project ]..NashvilleHousing a
JOIN [Portofilio Project ]..NashvilleHousing b
    on a.ParcelID = b.ParcelID
	and a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null


	--Breaking out adress into individual columns (adress, city) from  "PropertyAddress"
		-- exempl : 1808  FOX CHASE DR, GOODLETTSVILLE

select PropertyAddress
from [Portofilio Project ]..NashvilleHousing

SELECT 
    CASE 
        WHEN CHARINDEX(',', PropertyAddress) > 0 
        THEN SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)
        ELSE PropertyAddress
    END AS PropertySplitAddress,
    
    CASE 
        WHEN CHARINDEX(',', PropertyAddress) > 0 
        THEN LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)))
        ELSE NULL
    END AS PropertySplitCity
FROM [Portofilio Project ]..NashvilleHousing;



UPDATE [Portofilio Project]..NashvilleHousing
SET PropertySplitAddress = 
	Case 
	when CHARINDEX(',', PropertyAddress) > 0
	then SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)
	else PropertyAddress
	end;

ALTER TABLE [Portofilio Project]..NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE [Portofilio Project]..NashvilleHousing
SET PropertySplitCity = 
	Case 
	when CHARINDEX(',', PropertyAddress) > 0
	THEN LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)))
	else NULL 
	end;

SELECT PropertyAddress, PropertySplitAddress, PropertySplitCity
FROM [Portofilio Project ]..NashvilleHousing;

	--Breaking out adress into individual columns (adress, city, state) from "OwnerAddress"
		-- exempl : 1808  FOX CHASE DR, GOODLETTSVILLE, TN

select OwnerAddress
from [Portofilio Project ]..NashvilleHousing

select 
PARSENAME(replace(OwnerAddress, ',', '.'), 3), --adress 
PARSENAME(replace(OwnerAddress, ',', '.'), 2), --city 
PARSENAME(replace(OwnerAddress, ',', '.'), 1) --state
from [Portofilio Project ]..NashvilleHousing

	--Store the 3 columns 

ALTER TABLE [Portofilio Project ]..NashvilleHousing
ADD OwnerSplit_Address NVARCHAR(255),
    OwnerSplit_City NVARCHAR(255),
    OwnerSplit_State NVARCHAR(255);

UPDATE [Portofilio Project ]..NashvilleHousing
SET 
    OwnerSplit_Address = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerSplit_City    = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerSplit_State   = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

	--check the colomns

SELECT 
    OwnerAddress,
    OwnerSplit_Address,
    OwnerSplit_City,
    OwnerSplit_State
FROM [Portofilio Project ]..NashvilleHousing;


		--change Y and N to Yes and No in the column "SoldASVacant" 

select SoldASVacant
FROM [Portofilio Project ]..NashvilleHousing;


select distinct(SoldASVacant), COUNT(SoldASVacant)
FROM [Portofilio Project ]..NashvilleHousing
Group by SoldAsVacant
ORDER BY 2



UPDATE [Portofilio Project]..NashvilleHousing
SET SoldAsVacant =
    CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;


	--there are 3 adress at this colomun and they should be converted to NULL
	
UPDATE [Portofilio Project]..NashvilleHousing
SET SoldAsVacant = NULL
WHERE SoldAsVacant LIKE '%,%';



	-- objective : Remove Duplicates 
	--first , show duplicates 
WITH RowNumCTE AS (
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY 
            ParcelID,
            PropertyAddress,
            SalePrice,
            SaleDateConverted,
            LegalReference
        ORDER BY UniqueID
    ) AS row_num
FROM [Portofilio Project ]..NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1;


		--second, Remove Duplicates
WITH RowNumCTE AS (
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY 
            ParcelID,
            PropertyAddress,
            SalePrice,
            SaleDateConverted,
            LegalReference
        ORDER BY UniqueID
    ) AS row_num
FROM [Portofilio Project ]..NashvilleHousing
)
DELETE 
FROM RowNumCTE
WHERE row_num > 1

select *
from [Portofilio Project ]..NashvilleHousing


-- Delete unused columns

select *
from [Portofilio Project ]..NashvilleHousing

Alter Table [Portofilio Project ]..NashvilleHousing
Drop column OwnerAddress, TaxDistrict, PropertyAddress


Alter Table [Portofilio Project ]..NashvilleHousing
Drop column SaleDate
