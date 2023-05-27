-- CreateTable
CREATE TABLE "Appointment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "time" DATETIME NOT NULL,
    "notes" TEXT,
    "technicianId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    CONSTRAINT "Appointment_technicianId_fkey" FOREIGN KEY ("technicianId") REFERENCES "technician" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Appointment_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ServiceRequest" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "preferredDate" DATETIME NOT NULL,
    "notes" TEXT,
    "status" TEXT NOT NULL,
    "technicianId" INTEGER,
    "customerId" INTEGER NOT NULL,
    CONSTRAINT "ServiceRequest_technicianId_fkey" FOREIGN KEY ("technicianId") REFERENCES "technician" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ServiceRequest_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
