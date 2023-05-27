/*
  Warnings:

  - You are about to drop the `_ExpertiseToTechnician` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `updatedAt` to the `expertise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `expertise` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "_ExpertiseToTechnician_B_index";

-- DropIndex
DROP INDEX "_ExpertiseToTechnician_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_ExpertiseToTechnician";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_expertise" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "expertise_userId_fkey" FOREIGN KEY ("userId") REFERENCES "technician" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_expertise" ("id", "name") SELECT "id", "name" FROM "expertise";
DROP TABLE "expertise";
ALTER TABLE "new_expertise" RENAME TO "expertise";
CREATE UNIQUE INDEX "expertise_name_key" ON "expertise"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
