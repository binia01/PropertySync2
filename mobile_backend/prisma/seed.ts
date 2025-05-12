import { PrismaClient, Role, PropertyStatus, AppointmentStatus } from '@prisma/client';
import * as argon2 from 'argon2';

const prisma = new PrismaClient();

async function main() {
  // Clear existing data
  await prisma.appointment.deleteMany();
  await prisma.property.deleteMany();
  await prisma.user.deleteMany();

  // Hash default password
  const password = await argon2.hash('password123');

  // Create Sellers
  const [seller1, seller2, seller3] = await Promise.all([
    prisma.user.create({
      data: {
        email: 'seller1@example.com',
        firstname: 'Alice',
        lastname: 'Seller',
        hash: password,
        role: Role.SELLER,
      },
    }),
    prisma.user.create({
      data: {
        email: 'seller2@example.com',
        firstname: 'Bob',
        lastname: 'Seller',
        hash: password,
        role: Role.SELLER,
      },
    }),
    prisma.user.create({
      data: {
        email: 'seller3@example.com',
        firstname: 'Clara',
        lastname: 'Seller',
        hash: password,
        role: Role.SELLER,
      },
    }),
  ]);

  // Create Properties (with beds, baths, area)
  const [property1, property2, property3, property4, property5] = await Promise.all([
    prisma.property.create({
      data: {
        title: 'Modern Apartment in NYC',
        description: 'A beautiful modern apartment in the heart of New York.',
        price: 500000,
        location: 'New York',
        status: PropertyStatus.ACTIVE,
        sellerId: seller1.id,
        beds: 2,
        baths: 1,
        area: 850,
      },
    }),
    prisma.property.create({
      data: {
        title: 'Cozy House in LA',
        description: 'A cozy and quiet place to live.',
        price: 750000,
        location: 'Los Angeles',
        status: PropertyStatus.ACTIVE,
        sellerId: seller2.id,
        beds: 3,
        baths: 2,
        area: 1200,
      },
    }),
    prisma.property.create({
      data: {
        title: 'Luxury Villa in Miami',
        description: 'A lavish beachfront villa with stunning views.',
        price: 1500000,
        location: 'Miami',
        status: PropertyStatus.ACTIVE,
        sellerId: seller3.id,
        beds: 5,
        baths: 4,
        area: 3000,
      },
    }),
    prisma.property.create({
      data: {
        title: 'Studio Apartment in SF',
        description: 'Compact and perfect for singles.',
        price: 400000,
        location: 'San Francisco',
        status: PropertyStatus.ACTIVE,
        sellerId: seller1.id,
        beds: 1,
        baths: 1,
        area: 600,
      },
    }),
    prisma.property.create({
      data: {
        title: 'Countryside Cottage',
        description: 'Peaceful escape in the countryside.',
        price: 320000,
        location: 'Vermont',
        status: PropertyStatus.ACTIVE,
        sellerId: seller2.id,
        beds: 2,
        baths: 1,
        area: 900,
      },
    }),
  ]);

  // Create Buyers
  const [buyer1, buyer2, buyer3] = await Promise.all([
    prisma.user.create({
      data: {
        email: 'buyer1@example.com',
        firstname: 'Charlie',
        lastname: 'Buyer',
        hash: password,
        role: Role.BUYER,
      },
    }),
    prisma.user.create({
      data: {
        email: 'buyer2@example.com',
        firstname: 'Dana',
        lastname: 'Buyer',
        hash: password,
        role: Role.BUYER,
      },
    }),
    prisma.user.create({
      data: {
        email: 'buyer3@example.com',
        firstname: 'Elliot',
        lastname: 'Buyer',
        hash: password,
        role: Role.BUYER,
      },
    }),
  ]);

  // Appointments (bookings)
  await Promise.all([
    prisma.appointment.create({
      data: {
        startTime: new Date(Date.now() + 1000 * 60 * 60 * 24), // 1 day later
        Date: new Date(),
        propertyId: property1.id,
        buyerId: buyer1.id,
        sellerId: seller1.id,
        status: AppointmentStatus.PENDING,
      },
    }),
    prisma.appointment.create({
      data: {
        startTime: new Date(Date.now() + 1000 * 60 * 60 * 48), // 2 days later
        Date: new Date(),
        propertyId: property2.id,
        buyerId: buyer2.id,
        sellerId: seller2.id,
        status: AppointmentStatus.CONFIRMED,
      },
    }),
    prisma.appointment.create({
      data: {
        startTime: new Date(Date.now() + 1000 * 60 * 60 * 72), // 3 days later
        Date: new Date(),
        propertyId: property3.id,
        buyerId: buyer3.id,
        sellerId: seller3.id,
        status: AppointmentStatus.CANCELED,
      },
    }),
  ]);

  console.log('✅ Seed data created successfully.');
}

main()
  .catch((e) => {
    console.error('❌ Error while seeding:', e);
    return prisma.$disconnect().finally(() => process.exit(1));
  })
  .finally(() => prisma.$disconnect());

