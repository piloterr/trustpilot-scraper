<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Trustpilot Scraper API by Piloterr – scrape Trustpilot data as JSON" width="100%"></a>
</p>

# Trustpilot Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Trustpilot Scraper API** lets you extract public data from Trustpilot as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Trustpilot Company Info API** — Retrieve Trustpilot company profile data, including trust score, star rating, categories, contact info, and review response behavior.

Use it for lead generation, CRM enrichment, market mapping, investment research or job market analytics.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Trustpilot Company Info API](#trustpilot-company-info-api) | `/v2/trustpilot/company/info` | 1 | Retrieve Trustpilot company profile data, including trust score, star rating, categories, contact info, and review response behavior. |

## Table of contents

- [How it works](#how-it-works)
- [Trustpilot Company Info API](#trustpilot-company-info-api)
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

## Trustpilot Company Info API

Retrieve Trustpilot company profile data, including trust score, star rating, categories, contact info, and review response behavior.

`GET | POST https://api.piloterr.com/v2/trustpilot/company/info` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | A Trustpilot company URL or domain name. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/trustpilot/company/info",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.trustpilot.com/review/nordvpn.com",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type TrustpilotCompanyInfo = {
  id?: string;
  stars?: number;
  activity?: {
    is_claimed?: boolean;
    reply_behavior?: {
      reply_percentage?: number;
      average_days_to_reply?: number;
    };
  };
  is_closed?: boolean;
  breadcrumb?: {
    mid_level_display_name?: string;
    top_level_display_name?: string;
    bottom_level_display_name?: string;
  };
  categories?: {
    id?: string;
    name?: string;
    rank?: string;
    is_primary?: boolean;
  }[];
  is_claimed?: boolean;
  trust_score?: number;
  website_url?: string;
  contact_info?: {
    city?: string;
    email?: string;
    phone?: string;
    country?: string;
  };
  display_name?: string;
  website_title?: string;
  similar_business?: {
    name?: string;
    domain?: string;
  }[];
};

const params = new URLSearchParams({
  "query": "https://www.trustpilot.com/review/nordvpn.com",
});

const response = await fetch(`https://api.piloterr.com/v2/trustpilot/company/info?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as TrustpilotCompanyInfo;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/trustpilot/company/info
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.trustpilot.com/review/nordvpn.com"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "51abc000000064000538d348",
  "stars": 4,
  "activity": {
    "is_claimed": true,
    "reply_behavior": {
      "reply_percentage": 98.93,
      "average_days_to_reply": -0.34
    }
  },
  "is_closed": false,
  "breadcrumb": {
    "mid_level_display_name": "Internet & Software",
    "top_level_display_name": "Electronics & Technology",
    "bottom_level_display_name": "VPN Service"
  },
  "categories": [
    {
      "id": "vpn_service",
      "name": "VPN Service",
      "rank": "15",
      "is_primary": true
    },
    {
      "id": "internet_service_provider",
      "name": "Internet Service Provider",
      "rank": "38"
    }
  ],
  "is_claimed": true,
  "trust_score": 4.2,
  "website_url": "https://nordvpn.com",
  "contact_info": {
    "city": "Panama City",
    "email": "example",
    "phone": "example",
    "country": "PA"
  },
  "display_name": "NordVPN",
  "website_title": "nordvpn.com",
  "similar_business": [
    {
      "name": "Surfshark",
      "domain": "surfshark.com"
    },
    {
      "name": "ExpressVPN",
      "domain": "expressvpn.com"
    }
  ]
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `stars` | integer |  |
| `activity` | object |  |
| `activity.is_claimed` | boolean |  |
| `activity.reply_behavior` | object |  |
| `is_closed` | boolean |  |
| `breadcrumb` | object |  |
| `breadcrumb.mid_level_display_name` | string |  |
| `breadcrumb.top_level_display_name` | string |  |
| `breadcrumb.bottom_level_display_name` | string |  |
| `categories[]` | object[] |  |
| `categories[].id` | string |  |
| `categories[].name` | string |  |
| `categories[].rank` | string |  |
| `categories[].is_primary` | boolean |  |
| `is_claimed` | boolean |  |
| `trust_score` | number |  |
| `website_url` | string |  |
| `contact_info` | object |  |
| `contact_info.city` | string |  |
| `contact_info.email` | string |  |
| `contact_info.phone` | string |  |
| `contact_info.country` | string |  |
| `display_name` | string |  |
| `website_title` | string |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Company Info |
|---|---|
| cURL (Bash) | [`company-info`](examples/curl/company_info.sh) |
| PHP | [`company-info`](examples/php/company_info.php) |
| C# | [`company-info`](examples/csharp/CompanyInfo.cs) |
| Go | [`company-info`](examples/go/company_info.go) |
| Java | [`company-info`](examples/java/CompanyInfoExample.java) |
| Ruby | [`company-info`](examples/ruby/company_info.rb) |
| Node.js | [`company-info`](examples/nodejs/company_info.mjs) |

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
- **One API key, hundreds of sources** — Trustpilot plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Trustpilot?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/trustpilot/company/info` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Trustpilot API return?

Each endpoint returns structured JSON: **Trustpilot Company Info** — `id`, `stars`, `activity`, `activity.is_claimed`, `activity.reply_behavior`, `is_closed`.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Company Database Scraper API](https://github.com/piloterr/company-data-api)
- [Crunchbase Scraper API](https://github.com/piloterr/crunchbase-scraper)
- [Europages Scraper API](https://github.com/piloterr/europages-scraper)
- [Fiverr Scraper API](https://github.com/piloterr/fiverr-scraper)
- [G2 Scraper API](https://github.com/piloterr/g2-scraper)
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

<sub>Trustpilot is a trademark of its respective owner. This repository is not affiliated with or endorsed by Trustpilot. Examples are released under the MIT license.</sub>
