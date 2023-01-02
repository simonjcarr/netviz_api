/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `group` will be added. If there are existing duplicate values, this will fail.
  - Made the column `groupId` on table `Node` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_groupId_fkey`;

-- AlterTable
ALTER TABLE `Node` MODIFY `groupId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `group` MODIFY `name` VARCHAR(191) NOT NULL DEFAULT 'None';

-- CreateIndex
CREATE UNIQUE INDEX `group_name_key` ON `group`(`name`);

-- AddForeignKey
ALTER TABLE `Node` ADD CONSTRAINT `Node_groupId_fkey` FOREIGN KEY (`groupId`) REFERENCES `group`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
