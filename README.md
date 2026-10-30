<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="TED (EU tenders) Scraper API by Piloterr – scrape TED (EU tenders) data as JSON" width="100%"></a>
</p>

# TED (EU tenders) Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr TED (EU tenders) Scraper API** lets you extract public data from TED (EU tenders) as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **TED Notice API** — TED notice profile: buyer, lots, deadline, value and documents (1 credit).
- **TED Search API** — Search TED procurement notices by keyword or filters.

Use it for lead generation, CRM enrichment, market mapping, investment research or job market analytics.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [TED Notice API](#ted-notice-api) | `/v2/ted/notice` | 1 | TED notice profile |
| [TED Search API](#ted-search-api) | `/v2/ted/search` | 1 | Search TED procurement notices by keyword or filters. Returns notice cards and pagination (1 credit). |

## Table of contents

- [How it works](#how-it-works)
- [TED Notice API](#ted-notice-api)
- [TED Search API](#ted-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## TED Notice API

TED notice profile: buyer, lots, deadline, value and documents (1 credit).

`GET | POST https://api.piloterr.com/v2/ted/notice` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Publication number, or a TED notice URL. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ted/notice",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "30-2026",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type TedNotice = {
  cpv?: string[];
  url?: string;
  lots?: {
    title?: string;
    description?: string;
  }[];
  oj_s?: string;
  place?: string;
  title?: string;
  awards?: unknown[];
  currency?: unknown;
  deadline?: string;
  documents?: string[];
  languages?: string[];
  procedure?: string;
  buyer_name?: string;
  description?: string;
  legal_basis?: string;
  notice_type?: string;
  buyer_country?: string;
  dispatch_date?: string;
  value_display?: unknown;
  estimated_value?: unknown;
  publication_date?: string;
  publication_number?: string;
};

const params = new URLSearchParams({
  "query": "30-2026",
});

const response = await fetch(`https://api.piloterr.com/v2/ted/notice?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as TedNotice;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ted/notice
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "30-2026"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "cpv": [
    "50312610",
    "35125100"
  ],
  "url": "https://ted.europa.eu/en/notice/-/detail/30-2026",
  "lots": [
    {
      "title": "Analyse, télétransmission des données, maintenance des matériels existants",
      "description": "Analyse, télétransmission des données, maintenance des matériels existants"
    },
    {
      "title": "Maintenance, télétransmission, acquisition et installation de nouveaux matériels de comptages",
      "description": "Maintenance, télétransmission, acquisition et installation de nouveaux matériels de comptages"
    }
  ],
  "oj_s": "1/2026",
  "place": "FRK24",
  "title": "France – Maintenance of information technology equipment – OBSERVATOIRE DES MOBILITES. FOURNITURE, INSTALLATION D'INFRASTRUCTURES DE MATE…",
  "awards": [],
  "currency": null,
  "deadline": "2026-02-02",
  "documents": [
    "https://www.marches-publics.info/mpiaws/index.cfm?fuseaction=dematEnt.login&type=DCE&IDM=1760411"
  ],
  "languages": [
    "bul",
    "ces"
  ],
  "procedure": "open",
  "buyer_name": "SMMAG, Syndicat Mixte des Mobilités de l'Aire Grenobloise, Grenoble-Alpes Métropole",
  "description": "Le syndicat Mixte des Mobilités de l'Aire Grenobloise souhaite lancer en groupement de commandes avec Grenoble-Alpes Métropole, une consu…",
  "legal_basis": "32014L0024",
  "notice_type": "cn-standard",
  "buyer_country": "FRA",
  "dispatch_date": "2025-12-31",
  "value_display": null,
  "estimated_value": null,
  "publication_date": "2026-01-02",
  "publication_number": "30-2026"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `cpv` | string[] |  |
| `url` | string |  |
| `lots[]` | object[] |  |
| `lots[].title` | string |  |
| `lots[].description` | string |  |
| `oj_s` | string |  |
| `place` | string |  |
| `title` | string |  |
| `awards` | any[] |  |
| `currency` | object |  |
| `deadline` | string |  |
| `documents` | string[] |  |
| `languages` | string[] |  |
| `procedure` | string |  |
| `buyer_name` | string |  |
| `description` | string |  |
| `legal_basis` | string |  |
| `notice_type` | string |  |
| `buyer_country` | string |  |
| `dispatch_date` | string |  |
| `value_display` | object |  |
| `estimated_value` | object |  |
| `publication_date` | string |  |
| `publication_number` | string |  |

## TED Search API

Search TED procurement notices by keyword or filters. Returns notice cards and pagination (1 credit).

`GET | POST https://api.piloterr.com/v2/ted/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | — | Keyword, publication number, or a TED search URL. |
| `notice_type` | string | — | Notice code such as cn-standard or can-standard. Combined with AND. |
| `country` | string | — | Buyer country, ISO alpha-2 or alpha-3. FR becomes FRA. A country name returns 400. |
| `place` | string | — | Place of performance: country code or NUTS code such as FRK24. |
| `cpv` | string | — | CPV code or prefix. Digits and an optional star, for example 72000000 or 30*. |
| `buyer` | string | — | Buyer name, matched as a phrase. |
| `page` | number | — | Page from 1. next is always null: pass page + 1. A page past the last one returns 404. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ted/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "software",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type TedSearch = {
  results?: {
    cpv?: string[];
    url?: string;
    place?: string;
    title?: string;
    currency?: unknown;
    deadline?: string;
    buyer_name?: string;
    notice_type?: string;
    buyer_country?: string;
    value_display?: unknown;
    estimated_value?: unknown;
    publication_date?: string;
    publication_number?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "software",
});

const response = await fetch(`https://api.piloterr.com/v2/ted/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as TedSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ted/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "software"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "cpv": [
        "50312610",
        "35125100"
      ],
      "url": "https://ted.europa.eu/en/notice/-/detail/30-2026",
      "place": "FRK24",
      "title": "France – Maintenance of information technology equipment – OBSERVATOIRE DES MOBILITES. FOURNITURE, INSTALLATION D'INFRASTRUCTURES DE MATE…",
      "currency": null,
      "deadline": "2026-02-02",
      "buyer_name": "SMMAG, Syndicat Mixte des Mobilités de l'Aire Grenobloise, Grenoble-Alpes Métropole",
      "notice_type": "cn-standard",
      "buyer_country": "FRA",
      "value_display": null,
      "estimated_value": null,
      "publication_date": "2026-01-02",
      "publication_number": "30-2026"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 20,
    "total_pages": 1,
    "total_results": 1
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].cpv` | string[] |  |
| `results[].url` | string |  |
| `results[].place` | string |  |
| `results[].title` | string |  |
| `results[].currency` | object |  |
| `results[].deadline` | string |  |
| `results[].buyer_name` | string |  |
| `results[].notice_type` | string |  |
| `results[].buyer_country` | string |  |
| `results[].value_display` | object |  |
| `results[].estimated_value` | object |  |
| `results[].publication_date` | string |  |
| `results[].publication_number` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | TED Notice | TED Search |
|---|---|---|
| cURL (Bash) | [`notice`](examples/curl/notice.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`notice`](examples/php/notice.php) | [`search`](examples/php/search.php) |
| C# | [`notice`](examples/csharp/Notice.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`notice`](examples/go/notice.go) | [`search`](examples/go/search.go) |
| Java | [`notice`](examples/java/NoticeExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`notice`](examples/ruby/notice.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`notice`](examples/nodejs/notice.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Lead generation** — Build target account lists from public company data.
- **CRM enrichment** — Keep firmographics, websites and descriptions up to date.
- **Market mapping** — Map competitors and segments across countries and industries.
- **Investment research** — Screen companies, funding and signals for deal flow.
- **Job market analytics** — Track hiring, roles and salaries where available.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — TED (EU tenders) plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape TED (EU tenders)?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/ted/notice` **1**, `/v2/ted/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the TED (EU tenders) API return?

Each endpoint returns structured JSON: **TED Notice** — `cpv`, `url`, `lots[]`, `lots[].title`, `lots[].description`, `oj_s`; **TED Search** — `results[]`, `results[].cpv`, `results[].url`, `results[].place`, `results[].title`, `results[].currency`.

### How do I paginate TED (EU tenders) results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `country` — see the parameter tables above for accepted values.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Company Database Scraper API](https://github.com/piloterr/company-data-api)
- [Crunchbase Scraper API](https://github.com/piloterr/crunchbase-scraper)
- [Europages Scraper API](https://github.com/piloterr/europages-scraper)
- [Fiverr Scraper API](https://github.com/piloterr/fiverr-scraper)
- [g2-scraper](https://github.com/piloterr/g2-scraper)
- [github-scraper](https://github.com/piloterr/github-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>TED (EU tenders) is a trademark of its respective owner. This repository is not affiliated with or endorsed by TED (EU tenders). Examples are released under the MIT license.</sub>
