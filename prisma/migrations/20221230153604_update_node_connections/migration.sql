/*
  Warnings:

  - You are about to drop the `NodeConnections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `NodeConnections` DROP FOREIGN KEY `NodeConnections_connectionsFromId_fkey`;

-- DropForeignKey
ALTER TABLE `NodeConnections` DROP FOREIGN KEY `NodeConnections_connectionsToId_fkey`;

-- AlterTable
ALTER TABLE `Node` ADD COLUMN `connectedToId` INTEGER NULL;

-- DropTable
DROP TABLE `NodeConnections`;

-- AddForeignKey
ALTER TABLE `Node` ADD CONSTRAINT `Node_connectedToId_fkey` FOREIGN KEY (`connectedToId`) REFERENCES `Node`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
