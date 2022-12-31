/*
  Warnings:

  - You are about to drop the `NodeConnections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `NodeConnections` DROP FOREIGN KEY `NodeConnections_nodeId_fkey`;

-- DropForeignKey
ALTER TABLE `NodeConnections` DROP FOREIGN KEY `NodeConnections_targetId_fkey`;

-- AlterTable
ALTER TABLE `Node` ADD COLUMN `nodeId` INTEGER NULL;

-- DropTable
DROP TABLE `NodeConnections`;

-- AddForeignKey
ALTER TABLE `Node` ADD CONSTRAINT `Node_nodeId_fkey` FOREIGN KEY (`nodeId`) REFERENCES `Node`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
