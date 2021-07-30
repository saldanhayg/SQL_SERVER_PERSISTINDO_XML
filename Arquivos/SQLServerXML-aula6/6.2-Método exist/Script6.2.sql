
SELECT * FROM PERSON.PERSON;

SELECT * FROM PERSON.PERSON WHERE Demographics.exist('IndividualSurvey/YearlyIncome') = 1;

With XMLNAMESPACES
(Default N'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT * FROM PERSON.PERSON WHERE Demographics.exist('IndividualSurvey/YearlyIncome') = 1;
