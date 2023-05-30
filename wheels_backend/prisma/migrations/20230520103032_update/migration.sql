/*
  Warnings:

  - You are about to drop the column `Garage` on the `technician` table. All the data in the column will be lost.
  - Added the required column `garage` to the `technician` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "expertise_name_key";

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
    "garage" TEXT NOT NULL,
    "location" TEXT NOT NULL
);
INSERT INTO "new_technician" ("about", "createdAt", "email", "hash", "id", "location", "name", "phone", "updatedAt") SELECT "about", "createdAt", "email", "hash", "id", "location", "name", "phone", "updatedAt" FROM "technician";
DROP TABLE "technician";
ALTER TABLE "new_technician" RENAME TO "technician";
CREATE UNIQUE INDEX "technician_email_key" ON "technician"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
