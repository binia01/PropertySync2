/*
  Warnings:

  - Added the required column `Date` to the `appointments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "appointments" ADD COLUMN     "Date" TIMESTAMP(3) NOT NULL;
