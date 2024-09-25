SELECT 
    dp.name AS UserName,
    dp.type_desc AS UserType,
    s.name AS SchemaName,
    o.name AS ObjectName,
    p.permission_name AS PermissionName
FROM 
    sys.database_permissions AS p
JOIN 
    sys.database_principals AS dp
    ON p.grantee_principal_id = dp.principal_id
JOIN 
    sys.objects AS o
    ON p.major_id = o.object_id
JOIN 
    sys.schemas AS s
    ON o.schema_id = s.schema_id
ORDER BY 
    dp.name, s.name, o.name, p.permission_name;
