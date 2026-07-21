# Propostas

Páginas de proposta comercial, uma por cliente. Ficam fora do CRM (sem
login) mas usam o mesmo projeto Supabase pra guardar o registro de quem
assinou.

## Antes de usar pela primeira vez

Rodar `supabase/propostas.sql` uma vez no SQL Editor do projeto Supabase
(cria a tabela `propostas` e as políticas de acesso). Sem isso, a
assinatura ainda gera e baixa o PDF normalmente, só não salva o registro
no servidor.

## feerxsstudios.html

- **Código de acesso:** `feerxs2026` — passa pro cliente por fora (WhatsApp,
  não pelo mesmo canal do link) antes de mandar o link da proposta. Pra
  trocar, edita a constante `ACCESS_CODE` no `<script>` do arquivo.
- **Link:** `propostas/feerxsstudios.html` (GitHub Pages ou onde o repo
  estiver publicado)
- Depois de assinado, o registro completo (nome, documento, imagem da
  assinatura e PDF em base64) fica salvo na tabela `propostas` do
  Supabase — visível só pra quem loga no CRM.
