-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_technician" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
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
