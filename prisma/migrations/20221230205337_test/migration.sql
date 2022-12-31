/*
  Warnings:

  - You are about to drop the column `connectedFromNodeId` on the `Node` table. All the data in the column will be lost.
  - You are about to drop the column `nodeId` on the `Node` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_connectedFromNodeId_fkey`;

-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_nodeId_fkey`;

-- AlterTable
ALTER TABLE `Node` DROP COLUMN `connectedFromNodeId`,
    DROP COLUMN `nodeId`;

-- CreateTable
CREATE TABLE `_NodeConnections` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_NodeConnections_AB_unique`(`A`, `B`),
    INDEX `_NodeConnections_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_NodeConnections` ADD CONSTRAINT `_NodeConnections_A_fkey` FOREIGN KEY (`A`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_NodeConnections` ADD CONSTRAINT `_NodeConnections_B_fkey` FOREIGN KEY (`B`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
