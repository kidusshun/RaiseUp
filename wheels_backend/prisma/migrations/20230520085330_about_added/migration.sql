/*
  Warnings:

  - Added the required column `about` to the `technician` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Expertise" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ExpertiseToTechnician" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_ExpertiseToTechnician_A_fkey" FOREIGN KEY ("A") REFERENCES "Expertise" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ExpertiseToTechnician_B_fkey" FOREIGN KEY ("B") REFERENCES "technician" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_technician" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "about" TEXT NOT NULL
);
INSERT INTO "new_technician" ("createdAt", "email", "hash", "id", "name", "updatedAt") SELECT "createdAt", "email", "hash", "id", "name", "updatedAt" FROM "technician";
DROP TABLE "technician";
ALTER TABLE "new_technician" RENAME TO "technician";
CREATE UNIQUE INDEX "technician_email_key" ON "technician"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Expertise_name_key" ON "Expertise"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_ExpertiseToTechnician_AB_unique" ON "_ExpertiseToTechnician"("A", "B");

-- CreateIndex
CREATE INDEX "_ExpertiseToTechnician_B_index" ON "_ExpertiseToTechnician"("B");
