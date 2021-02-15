/* Task 1a */
SELECT P.Id AS [Property ID], O.Id AS [Owner ID], P.Name AS [Property Name] FROM dbo.Property P
LEFT OUTER JOIN dbo.OwnerProperty OP
ON P.ID = OP.PropertyId
LEFT OUTER JOIN dbo.Owners O
ON OP.OwnerId = O.Id
WHERE O.ID = 1426

/* Task 1b */
SELECT P.Id AS [Property ID], O.Id AS [Owner ID], P.Name AS [Property Name], PHV.Value AS [Current Home Value] FROM dbo.Property P
LEFT OUTER JOIN dbo.OwnerProperty OP
ON P.ID = OP.PropertyId
LEFT OUTER JOIN dbo.Owners O
ON OP.OwnerId = O.Id
LEFT OUTER JOIN dbo.PropertyHomeValue PHV
ON PHV.PropertyId = P.Id
WHERE O.ID = 1426

/* Task 1c.i */
SELECT P.Id AS [Property ID],
P.Name AS [Property Name],
TP.PaymentAmount AS [Payment Amount],
TRT.Name AS [Payment Type],
TP.StartDate,
TP.EndDate,
 CASE
    WHEN TP.PaymentFrequencyId ='1' THEN TP.PaymentAmount*52
    WHEN TP.PaymentFrequencyId ='2' THEN TP.PaymentAmount*26
    WHEN TP.PaymentFrequencyId ='3' THEN TP.PaymentAmount*12
 ELSE null END AS [Total Payment]
    FROM Property P
    INNER JOIN OwnerProperty OP
    ON P.Id = OP.PropertyId
    INNER JOIN PropertyHomeValue PHV
    ON OP.PropertyId = PHV.PropertyId
    INNER JOIN TenantProperty TP
    ON P.Id = TP.PropertyId
    INNER JOIN  TargetRentType TRT
    ON TP.PaymentFrequencyId = TRT.Id
    WHERE OP.OwnerId = 1426 AND PHV.IsActive = 1


/* Task 1c.ii */
SELECT P.Id AS [Property ID], O.Id AS [Owner ID], P.Name AS [Property Name], PF.Yield FROM dbo.Property P
LEFT OUTER JOIN dbo.OwnerProperty OP
ON P.Id = OP.PropertyId
LEFT OUTER JOIN dbo.Owners O
ON OP.OwnerId = O.Id
LEFT OUTER JOIN dbo.PropertyFinance PF
ON PF.PropertyId = P.Id
WHERE O.ID = 1426

/* Task 1d */
SELECT J.Id AS [Job ID], J.JobDescription AS [Job Description], P.Id AS [Property ID], P.Name AS [Property Name] FROM dbo.Job J
INNER JOIN dbo.JobMedia JM
ON J.Id = JM.JobId
INNER JOIN dbo.Property P
ON P.Id = J.PropertyId
WHERE JM.IsActive = 1
ORDER BY J.Id ASC

/* Task 1e */
SELECT P.Id AS [Property ID], P.Name AS [Property Name], TP.TenantId AS [Tenant ID], PN.FirstName AS [Tenant First Name], PN.LastName AS [Tenant Last Name], PRP.Amount AS [Rent Amount], TPF.Name AS [Payment Method] FROM dbo.Property P
LEFT OUTER JOIN dbo.OwnerProperty OP
ON P.Id = OP.PropertyId
LEFT OUTER JOIN dbo.Owners O
ON OP.OwnerId = O.Id
INNER JOIN dbo.TenantProperty TP
ON TP.PropertyId = P.Id
INNER JOIN dbo.Person PN
ON PN.Id = TP.TenantId
INNER JOIN dbo.PropertyRentalPayment PRP
ON PRP.PropertyId = P.Id
INNER JOIN dbo.TenantPaymentFrequencies TPF
ON TPF.Id = TP.PaymentFrequencyId
WHERE O.ID = 1426 AND TP.IsActive = 1