/*
  Warnings:

  - Added the required column `area` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `baths` to the `properties` table without a default value. This is not possible if the table is not empty.
  - Added the required column `beds` to the `properties` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "properties" ADD COLUMN     "area" INTEGER NOT NULL,
ADD COLUMN     "baths" INTEGER NOT NULL,
ADD COLUMN     "beds" INTEGER NOT NULL;
