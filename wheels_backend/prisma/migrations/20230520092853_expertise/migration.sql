/*
  Warnings:

  - You are about to drop the `Expertise` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `Garage` to the `technician` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location` to the `technician` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `technician` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Expertise_name_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Expertise";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "expertise" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
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
    "about" TEXT NOT NULL,
    "phone" INTEGER NOT NULL,
    "Garage" TEXT NOT NULL,
    "location" TEXT NOT NULL
);
INSERT INTO "new_technician" ("about", "createdAt", "email", "hash", "id", "name", "updatedAt") SELECT "about", "createdAt", "email", "hash", "id", "name", "updatedAt" FROM "technician";
DROP TABLE "technician";
ALTER TABLE "new_technician" RENAME TO "technician";
CREATE UNIQUE INDEX "technician_email_key" ON "technician"("email");
CREATE TABLE "new__ExpertiseToTechnician" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_ExpertiseToTechnician_A_fkey" FOREIGN KEY ("A") REFERENCES "expertise" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ExpertiseToTechnician_B_fkey" FOREIGN KEY ("B") REFERENCES "technician" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new__ExpertiseToTechnician" ("A", "B") SELECT "A", "B" FROM "_ExpertiseToTechnician";
DROP TABLE "_ExpertiseToTechnician";
ALTER TABLE "new__ExpertiseToTechnician" RENAME TO "_ExpertiseToTechnician";
CREATE UNIQUE INDEX "_ExpertiseToTechnician_AB_unique" ON "_ExpertiseToTechnician"("A", "B");
CREATE INDEX "_ExpertiseToTechnician_B_index" ON "_ExpertiseToTechnician"("B");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "expertise_name_key" ON "expertise"("name");
