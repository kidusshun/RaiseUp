-- CreateTable
CREATE TABLE "startup" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "investor" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "startup_email_key" ON "startup"("email");

-- CreateIndex
CREATE UNIQUE INDEX "investor_email_key" ON "investor"("email");
