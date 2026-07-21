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

-- Remove a política antiga (só liberava insert pra quem tá "anônimo").
-- Quem já estiver logado no CRM no mesmo navegador acessa a página de
-- proposta como usuário autenticado, não anônimo, e a política antiga
-- bloqueava esse caso.
drop policy if exists "Qualquer um pode assinar (insert)" on propostas;

-- Qualquer visitante consegue INSERIR o registro da assinatura,
-- esteja logado no CRM ou não (write-only pro público: ninguém de
-- fora consegue listar ou ler assinaturas de outros clientes).
create policy "Qualquer um pode assinar (insert)"
  on propostas for insert
  to public
  with check (true);

-- Leitura fica restrita a usuários autenticados do CRM (equipe Morph).
drop policy if exists "Só a equipe Morph le as propostas" on propostas;
create policy "Só a equipe Morph le as propostas"
  on propostas for select
  to authenticated
  using (true);
