
SELECT * FROM PERSON.PERSON;

With XMLNAMESPACES
(Default N'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT * FROM PERSON.PERSON WHERE Demographics.exist('IndividualSurvey/TotalPurchaseYTD') = 1;

With XMLNAMESPACES
(Default N'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT * FROM PERSON.PERSON WHERE Demographics.exist('IndividualSurvey[TotalPurchaseYTD > 9000]') = 1;

With XMLNAMESPACES
(Default N'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT * FROM PERSON.PERSON WHERE Demographics.exist('(/IndividualSurvey/Education)[1] << (/IndividualSurvey/Occupation)[1]') = 0
AND Demographics.exist('IndividualSurvey/Education') = 1 AND Demographics.exist('IndividualSurvey/Occupation') = 1