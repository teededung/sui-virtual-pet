/// Module: virtual_pet
module virtual_pet::virtual_pet;

// struct
public struct Pet has key, store {
    id: UID,
    hunger: u64, // 0: hungry, 100: full
    happiness: u64, // 0: sad, 100: happy
}

public struct PetHouse has key {
    id: UID,
    pets_created: u64,
}

// init function
fun init(ctx: &mut TxContext) {
    let house = PetHouse {
        id: object::new(ctx),
        pets_created: 0,
    };

    transfer::transfer(house, ctx.sender());
}

// public function
public fun create_pet(hunger: u64, happiness: u64, ctx: &mut TxContext): Pet {
    Pet {
        id: object::new(ctx),
        hunger,
        happiness,
    }
}

// entry function
entry fun new_pet(house: &mut PetHouse, hunger: u64, happiness: u64, ctx: &mut TxContext) {
    house.pets_created = house.pets_created + 1;
    let pet = create_pet(hunger, happiness, ctx);
    transfer::public_transfer(pet, ctx.sender());
}

entry fun feed(pet: &mut Pet) {
    if (pet.hunger > 20) {
        pet.hunger = pet.hunger - 20;
    } else {
        pet.hunger = 0;
    };
    pet.happiness = pet.happiness + 10;
}

entry fun play(pet: &mut Pet) {
    pet.hunger = pet.hunger + 20;
    pet.happiness = pet.happiness + 10;
}
