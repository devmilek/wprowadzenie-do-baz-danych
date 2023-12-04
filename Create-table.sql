-- Tworzenie tabeli Profile
-- Tworzenie tabeli Profile
CREATE TABLE Profile (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(MAX),
    image NVARCHAR(MAX),
    bio NVARCHAR(MAX),
    email NVARCHAR(255) UNIQUE,
    hashedPassword NVARCHAR(MAX),
    emailVerified BIT DEFAULT 0,
    emailVerificationToken NVARCHAR(255) UNIQUE,
    resetPasswordToken NVARCHAR(255) UNIQUE,
    resetPasswordTokenExpiry DATETIME,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

-- Tworzenie tabeli Recipe
CREATE TABLE Recipe (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(MAX),
    description NVARCHAR(MAX),
    image NVARCHAR(MAX),
    difficulty NVARCHAR(50) DEFAULT 'EASY',
    preparationTime INT,
    published BIT DEFAULT 0,
    servingType NVARCHAR(50) DEFAULT 'SERVINGS',
    servingAmount INT DEFAULT 1,
    categoryId INT,
    profileId INT,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (categoryId) REFERENCES Category(id),
    FOREIGN KEY (profileId) REFERENCES Profile(id)
);

-- Pozostałe instrukcje CREATE TABLE dla pozostałych modeli i relacji...



-- Tworzenie tabeli PreparationStep
CREATE TABLE PreparationStep (
    id INT IDENTITY(1,1) PRIMARY KEY,
    description NVARCHAR(MAX),
    position INT,
    image NVARCHAR(MAX),
    recipeId INT,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id)
);

-- Tworzenie tabeli Ingredient
CREATE TABLE Ingredient (
    id INT IDENTITY(1,1) PRIMARY KEY,
    quantity INT,
    unit NVARCHAR(MAX),
    name NVARCHAR(MAX),
    recipeId INT,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id)
);

-- Tworzenie tabeli Image
CREATE TABLE Image (
    id INT IDENTITY(1,1) PRIMARY KEY,
    url NVARCHAR(MAX),
    alt NVARCHAR(MAX),
    size INT,
    name NVARCHAR(MAX),
    recipeId INT,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id)
);

-- Tworzenie tabeli Category
CREATE TABLE Category (
    id INT IDENTITY(1,1) PRIMARY KEY,
    slug NVARCHAR(255) UNIQUE,
    name NVARCHAR(MAX),
    image NVARCHAR(MAX),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

-- Tworzenie tabeli Occasion
CREATE TABLE Occasion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(MAX),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

-- Tworzenie tabeli OccasionsOnRecipes
CREATE TABLE OccasionsOnRecipes (
    recipeId INT,
    occasionId INT,
    assignedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (recipeId, occasionId),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id),
    FOREIGN KEY (occasionId) REFERENCES Occasion(id)
);

-- Tworzenie tabeli Cuisine
CREATE TABLE Cuisine (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(MAX),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

-- Tworzenie tabeli CuisinesOnRecipes
CREATE TABLE CuisinesOnRecipes (
    recipeId INT,
    cuisineId INT,
    assignedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (recipeId, cuisineId),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id),
    FOREIGN KEY (cuisineId) REFERENCES Cuisine(id)
);

-- Tworzenie tabeli Diet
CREATE TABLE Diet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(MAX),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

-- Tworzenie tabeli DietsOnRecipes
CREATE TABLE DietsOnRecipes (
    recipeId INT,
    dietId INT,
    assignedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (recipeId, dietId),
    FOREIGN KEY (recipeId) REFERENCES Recipe(id),
    FOREIGN KEY (dietId) REFERENCES Diet(id)
);