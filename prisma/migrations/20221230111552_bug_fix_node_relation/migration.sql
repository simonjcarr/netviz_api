/*
  Warnings:

  - You are about to drop the `_connectedFrom` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_connectedFrom` DROP FOREIGN KEY `_connectedFrom_A_fkey`;

-- DropForeignKey
ALTER TABLE `_connectedFrom` DROP FOREIGN KEY `_connectedFrom_B_fkey`;

-- DropTable
DROP TABLE `_connectedFrom`;

-- CreateTable
CREATE TABLE `_nodeConnection` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_nodeConnection_AB_unique`(`A`, `B`),
    INDEX `_nodeConnection_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_nodeConnection` ADD CONSTRAINT `_nodeConnection_A_fkey` FOREIGN KEY (`A`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_nodeConnection` ADD CONSTRAINT `_nodeConnection_B_fkey` FOREIGN KEY (`B`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
