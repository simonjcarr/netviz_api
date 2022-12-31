-- AlterTable
ALTER TABLE `Node` ADD COLUMN `connectionId` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `Node` ADD CONSTRAINT `Node_connectionId_fkey` FOREIGN KEY (`connectionId`) REFERENCES `Node`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
