CREATE DEFINER=`root`@`localhost` PROCEDURE `info_city`(
in city_name varchar(150)
)
BEGIN
SELECT 
    cs.title, rg.title, cou.title
FROM
    _cities cs
        JOIN
    _regions rg ON cs.region_id = rg.id
        JOIN
    _countries cou ON rg.country_id = cou.id
WHERE
    cs.title = city_name;
END