/*
  Warnings:

  - You are about to alter the column `phone` on the `technician` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.
  - You are about to drop the column `type` on the `ServiceRequest` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "admin" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "role" TEXT NOT NULL
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
    "role" TEXT NOT NULL,
    "about" TEXT,
    "phone" BIGINT,
    "garage" TEXT,
    "location" TEXT
);
INSERT INTO "new_technician" ("about", "createdAt", "email", "garage", "hash", "id", "location", "name", "phone", "role", "updatedAt") SELECT "about", "createdAt", "email", "garage", "hash", "id", "location", "name", "phone", "role", "updatedAt" FROM "technician";
DROP TABLE "technician";
ALTER TABLE "new_technician" RENAME TO "technician";
CREATE UNIQUE INDEX "technician_email_key" ON "technician"("email");
CREATE TABLE "new_ServiceRequest" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "preferredDate" DATETIME NOT NULL,
    "notes" TEXT,
    "status" TEXT NOT NULL,
    "technicianId" INTEGER,
    "customerId" INTEGER NOT NULL,
    CONSTRAINT "ServiceRequest_technicianId_fkey" FOREIGN KEY ("technicianId") REFERENCES "technician" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ServiceRequest_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ServiceRequest" ("customerId", "id", "notes", "preferredDate", "status", "technicianId") SELECT "customerId", "id", "notes", "preferredDate", "status", "technicianId" FROM "ServiceRequest";
DROP TABLE "ServiceRequest";
ALTER TABLE "new_ServiceRequest" RENAME TO "ServiceRequest";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "admin_email_key" ON "admin"("email");
