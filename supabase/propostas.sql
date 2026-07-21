-- Rode isso uma vez no SQL Editor do projeto Supabase usado pelo CRM
-- (mesmo projeto configurado em index.html e em propostas/*.html).
-- Guarda o registro de cada proposta assinada: quem assinou, a imagem
-- da assinatura e o PDF gerado, em base64.

create table if not exists propostas (
  id uuid primary key default gen_random_uuid(),
  slug text not null,
  cliente text not null,
  assinante_nome text not null,
  assinante_doc text not null,
  assinatura_png text not null,
  pdf_base64 text not null,
  assinado_em timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table propostas enable row level security;

-- A página de proposta usa a chave anon só pra INSERIR o registro da
-- assinatura (write-only pro público). Ninguém de fora consegue listar
-- ou ler assinaturas de outros clientes com a chave anon.
create policy "Qualquer um pode assinar (insert)"
  on propostas for insert
  to anon
  with check (true);

-- Leitura fica restrita a usuários autenticados do CRM (equipe Morph).
create policy "Só a equipe Morph le as propostas"
  on propostas for select
  to authenticated
  using (true);
