# Virtual Pet - Sui Move Smart Contract

A smart contract on the Sui blockchain for creating and managing virtual pets. Each pet has two primary attributes: **hunger** and **happiness**, both ranging from 0 to 100.

## Features

- **Create New Pet**: Generate a pet with custom initial hunger and happiness levels.
- **Feed**: Decrease the pet's hunger level and increase its happiness.
- **Play**: Increase the pet's happiness, but also make it hungrier.

## Structure

### Structs

- **Pet**: The pet object with the following attributes:
- `hunger`: Hunger level (0 = hungry, 100 = full).
- `happiness`: Happiness level (0 = sad, 100 = happy).

- **PetHouse**: A container object used to track the total number of pets created.

### Functions

- `init`: An initializer function that runs automatically upon deployment to create a `PetHouse`.
- `new_pet`: An entry function to create a new pet.
- `feed`: An entry function to feed the pet.
- `play`: An entry function to play with the pet.

## Setup and Build

```bash
# Navigate to the project directory
cd virtual_pet

# Build the package
sui move build

# Run tests
sui move test

```

## Publish Package

```bash
sui client publish --gas-budget 100000000

```

After publishing, you will receive a `Package ID`. Save this ID to use in subsequent function calls.

## Usage Guide

### 1. Get the PetHouse Object ID

After deploying the package, a `PetHouse` object is created and transferred to your address. To find its Object ID:

```bash
sui client objects

```

Look for an object with the type `virtual_pet::virtual_pet::PetHouse`.

### 2. Create a New Pet

Use the `new_pet` entry function to create a new pet:

```bash
sui client call \
--package <PACKAGE_ID> \
--module virtual_pet \
--function new_pet \
--args <PET_HOUSE_OBJECT_ID> 50 50 \
--gas-budget 100000000

```

**Parameter Explanation:**

- `<PACKAGE_ID>`: The ID of your published package.
- `<PET_HOUSE_OBJECT_ID>`: The Object ID of the PetHouse.
- `50 50`: Initial values for `hunger` and `happiness` (both set to 50).

**Example:**

```bash
sui client call \
--package 0xac0c26c69474848e0daecd28fb429dd1aee9dfe8ec5d04f4cb059bc4e9fe1688 \
--module virtual_pet \
--function new_pet \
--args 0x8c2713161306596a957672ff8b00b3a4d4a711b907a40d20094a2065029e4dae 50 50 \
--gas-budget 100000000

```

Once created successfully, a `Pet` object will be transferred to your address. Make sure to save the **Pet Object ID**.

### 3. Feed the Pet

Use the `feed` entry function. This action will:

- Decrease `hunger` by 20 (minimum value is 0).
- Increase `happiness` by 10.

```bash
sui client call \
--package <PACKAGE_ID> \
--module virtual_pet \
--function feed \
--args <PET_OBJECT_ID> \
--gas-budget 100000000

```

### 4. Play with the Pet

Use the `play` entry function. This action will:

- Increase `hunger` by 20.
- Increase `happiness` by 10.

```bash
sui client call \
--package <PACKAGE_ID> \
--module virtual_pet \
--function play \
--args <PET_OBJECT_ID> \
--gas-budget 100000000

```

### 5. View Pet Information

To check the current status of your pet (hunger, happiness):

```bash
sui client object <PET_OBJECT_ID>

```

## Notes

- `hunger` and `happiness` values range from 0 to 100.
- During `feed`, if `hunger` is already below 20, it will be reset to 0.
- During `play`, `hunger` may exceed 100 if not capped in the logic.
- Every time a new pet is created via `new_pet`, the `pets_created` counter in the `PetHouse` increases by 1.
