USE [BDD_Reassort]
GO

/****** Objet : Table [dbo].[utilisateurs] Date du script : 20/01/2022 12:17:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[utilisateurs];
DROP TABLE [dbo].[roles];
DROP TABLE [dbo].[langues];

GO
CREATE TABLE [dbo].[langues] (
    [Id]        INT  IDENTITY (0, 1) NOT NULL,
    [NUM_LANGUE]  INT  NULL,
    [NOM_LANGUE]  TEXT NULL,
    [DESC_LANGUE] TEXT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
CREATE TABLE [dbo].[roles] (
    [Id]        INT  IDENTITY (0, 1) NOT NULL,
    [NUM_ROLE]  INT  NULL,
    [NOM_ROLE]  TEXT NULL,
    [DESC_ROLE] TEXT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
CREATE TABLE [dbo].[utilisateurs] (
    [NUM_UTIL]       INT  IDENTITY (0, 1) NOT NULL,
    [NOM_UTIL]       TEXT NULL,
    [PRENOM_UTIL]    TEXT NULL,
    [LOGIN_UTIL]     TEXT NULL,
    [UTIL_ACTIF]     BIT  NULL,
    [NUM_ROLE]       INT  NULL,
	[NUM_LANGUE]       INT  NULL,
    [DATE_FIN_ACTIF] DATE NULL,
    [DATE_DEB_ACTIF] DATE NULL
);

GO
SET IDENTITY_INSERT [dbo].[utilisateurs] ON
INSERT INTO [dbo].[utilisateurs] ([NUM_UTIL], [NOM_UTIL], [PRENOM_UTIL], [LOGIN_UTIL], [UTIL_ACTIF], [NUM_ROLE], [NUM_LANGUE], [DATE_FIN_ACTIF], [DATE_DEB_ACTIF]) VALUES (0, N'Daumand', N'David', N'david', 1, 1,1, N'2022-04-30', N'2021-10-07')
INSERT INTO [dbo].[utilisateurs] ([NUM_UTIL], [NOM_UTIL], [PRENOM_UTIL], [LOGIN_UTIL], [UTIL_ACTIF], [NUM_ROLE], [NUM_LANGUE], [DATE_FIN_ACTIF], [DATE_DEB_ACTIF]) VALUES (1000, N'Daumand', N'David', N'david.daumand@groupe-celios.fr', 1, 2,1, N'2022-01-29', N'2022-01-20')
SET IDENTITY_INSERT [dbo].[utilisateurs] OFF

SET IDENTITY_INSERT [dbo].[roles] ON
INSERT INTO [dbo].[roles] ([Id], [NUM_ROLE], [NOM_ROLE], [DESC_ROLE]) VALUES (0, 1, N'Administrateur', N'Administrateur')
INSERT INTO [dbo].[roles] ([Id], [NUM_ROLE], [NOM_ROLE], [DESC_ROLE]) VALUES (1, 2, N'Commercial', N'Commercial')
SET IDENTITY_INSERT [dbo].[roles] OFF

SET IDENTITY_INSERT [dbo].[langues] ON
INSERT INTO [dbo].[langues] ([Id], [NUM_LANGUE], [NOM_LANGUE], [DESC_LANGUE]) VALUES (0, 1, N'FR', N'FR')
INSERT INTO [dbo].[langues] ([Id], [NUM_LANGUE], [NOM_LANGUE], [DESC_LANGUE]) VALUES (1, 2, N'EN', N'EN')
SET IDENTITY_INSERT [dbo].[langues] OFF

GO
CREATE PROCEDURE [dbo].[insertUser] (
	@nom_Util varchar(50),
	@prenom_Util varchar(50),
	@login_Util varchar(50),
	@num_Role int,
	@num_Langue int,
	@date_Fin_Actif datetime)

AS
BEGIN

INSERT INTO UTILISATEURS ([NOM_UTIL], [PRENOM_UTIL], [LOGIN_UTIL], [NUM_ROLE], [NUM_LANGUE], [UTIL_ACTIF], [DATE_DEB_ACTIF], [DATE_FIN_ACTIF])
VALUES (@nom_Util, @prenom_Util, @login_Util, @num_Role,@num_Langue, 1, GETDATE(), @date_Fin_Actif)

END

GO
CREATE PROCEDURE [dbo].[updateUser] (
	@nom_Util varchar(50),
	@prenom_Util varchar(50),
	@num_Util int, 
	@num_Role int,
	@num_Langue int,
	@util_Actif bit,
	@date_Fin_Actif datetime)

AS
BEGIN
		UPDATE UTILISATEURS SET [PRENOM_UTIL] = @prenom_Util, [NOM_UTIL] = @nom_Util, [NUM_ROLE] = @num_Role, [NUM_LANGUE] = @num_Langue, [UTIL_ACTIF] = @util_Actif, [DATE_FIN_ACTIF] = @date_Fin_Actif WHERE [NUM_UTIL] = @num_Util;
END

GO
CREATE PROCEDURE [dbo].[getListeUtilisateurs]
AS
BEGIN
	SELECT u.NUM_UTIL, u.NOM_UTIL, u.PRENOM_UTIL, u.LOGIN_UTIL, u.NUM_ROLE, r.NOM_ROLE, u.NUM_LANGUE, l.NOM_LANGUE, UTIL_ACTIF, u.DATE_DEB_ACTIF, u.DATE_FIN_ACTIF	
    FROM utilisateurs u
	INNER JOIN roles r ON u.NUM_ROLE = r.NUM_ROLE
	INNER JOIN langues l ON u.NUM_LANGUE = l.NUM_LANGUE
END

GO
CREATE PROCEDURE [dbo].[getCaractUtilisateur] (@login varchar(50))
AS
BEGIN
	SELECT NUM_UTIL, NOM_UTIL, PRENOM_UTIL, LOGIN_UTIL, UTIL_ACTIF, NUM_ROLE, NUM_LANGUE , DATE_FIN_ACTIF FROM utilisateurs WHERE CONVERT(NVARCHAR(MAX), LOGIN_UTIL) = @login;
END