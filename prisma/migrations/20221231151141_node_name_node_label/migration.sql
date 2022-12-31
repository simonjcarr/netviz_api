/*
  Warnings:

  - You are about to drop the column `name` on the `Node` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Node` DROP COLUMN `name`,
    ADD COLUMN `label` VARCHAR(191) NOT NULL DEFAULT 'Node';
