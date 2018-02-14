--Cifrado de una columna de una Base de datos
USE AdventureWorks;
GO

--If there is no master key, create one now. 
IF NOT EXISTS 
    (SELECT * FROM sys.symmetric_keys WHERE symmetric_key_id = 101)
    CREATE MASTER KEY ENCRYPTION BY 
    PASSWORD = '23987hxJKL969#ghf0%94467GRkjg5k3fd117r$$#1946kcj$n44nhdlj'
GO

CREATE CERTIFICATE HumanResources001
   WITH SUBJECT = 'Employee Social Security Numbers';
GO

CREATE SYMMETRIC KEY SSN_Key_01
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE HumanResources001;
GO

USE AdventureWorks;
GO

-- Create a column in which to store the encrypted data.
ALTER TABLE HumanResources.Employee
    ADD EncryptedNationalIDNumber varbinary(128); 
GO

-- Open the symmetric key with which to encrypt the data.
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE HumanResources001;

-- Encrypt the value in column NationalIDNumber with symmetric 
-- key SSN_Key_01. Save the result in column EncryptedNationalIDNumber.
UPDATE HumanResources.Employee
SET EncryptedNationalIDNumber = EncryptByKey(Key_GUID('SSN_Key_01'), NationalIDNumber);
GO

-- Verify the encryption.
-- First, open the symmetric key with which to decrypt the data.
OPEN SYMMETRIC KEY SSN_Key_01
   DECRYPTION BY CERTIFICATE HumanResources001;
GO

-- Now list the original ID, the encrypted ID, and the 
-- decrypted ciphertext. If the decryption worked, the original
-- and the decrypted ID will match.
SELECT NationalIDNumber, EncryptedNationalIDNumber 
    AS 'Encrypted ID Number',
    CONVERT(nvarchar, DecryptByKey(EncryptedNationalIDNumber)) 
    AS 'Decrypted ID Number'
    FROM HumanResources.Employee;
GO