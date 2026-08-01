-- Plak dit in Supabase: Project > SQL Editor > New query > Run

create table products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz default now()
);

create table orders (
  id uuid primary key default gen_random_uuid(),
  product text not null,
  team text not null,
  delivery text not null,
  done boolean default false,
  created_at timestamptz default now()
);

-- Toegang open zetten (geen inlog nodig om te bestellen of te beheren).
-- Let op: dit is dus niet extra beveiligd op databaseniveau, enkel het
-- wachtwoordschermpje op de Beheer-pagina houdt gewone bezoekers tegen.
alter table products enable row level security;
alter table orders enable row level security;

create policy "iedereen mag lezen en schrijven - products"
  on products for all using (true) with check (true);

create policy "iedereen mag lezen en schrijven - orders"
  on orders for all using (true) with check (true);
