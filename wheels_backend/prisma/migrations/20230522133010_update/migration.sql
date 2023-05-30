/*
  Warnings:

  - Added the required column `role` to the `customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `technician` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_customer" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "role" TEXT NOT NULL
);
INSERT INTO "new_customer" ("createdAt", "email", "hash", "id", "name", "updatedAt") SELECT "createdAt", "email", "hash", "id", "name", "updatedAt" FROM "customer";
DROP TABLE "customer";
ALTER TABLE "new_customer" RENAME TO "customer";
CREATE UNIQUE INDEX "customer_email_key" ON "customer"("email");
CREATE TABLE "new_technician" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "about" TEXT,
    "phone" INTEGER,
    "garage" TEXT,
    "location" TEXT
);
INSERT INTO "new_technician" ("about", "createdAt", "email", "garage", "hash", "id", "location", "name", "phone", "updatedAt") SELECT "about", "createdAt", "email", "garage", "hash", "id", "location", "name", "phone", "updatedAt" FROM "technician";
DROP TABLE "technician";
ALTER TABLE "new_technician" RENAME TO "technician";
CREATE UNIQUE INDEX "technician_email_key" ON "technician"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
