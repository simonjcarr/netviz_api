/*
  Warnings:

  - You are about to drop the column `connectionId` on the `Node` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_connectionId_fkey`;

-- AlterTable
ALTER TABLE `Node` DROP COLUMN `connectionId`;

-- CreateTable
CREATE TABLE `Connections` (
    `connectedFromId` INTEGER NOT NULL,
    `connectedToId` INTEGER NOT NULL,

    PRIMARY KEY (`connectedFromId`, `connectedToId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Connections` ADD CONSTRAINT `Connections_connectedFromId_fkey` FOREIGN KEY (`connectedFromId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Connections` ADD CONSTRAINT `Connections_connectedToId_fkey` FOREIGN KEY (`connectedToId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
