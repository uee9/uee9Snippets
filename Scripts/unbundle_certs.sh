#!/usr/bin/env bash
set -euxo pipefail

CERTS_DIR="$(cd "$(dirname "$0")" && pwd)"

for bundle in "${CERTS_DIR}"/*.pem "${CERTS_DIR}"/*.crt; do
  [ -f "$bundle" ] || continue

  bundle_name=$(basename "${bundle%.*}")

  cert_count=$(python3 -c "print(open('${bundle}').read().count('-----BEGIN CERTIFICATE-----'))")

  if [ "$cert_count" -le 1 ]; then
    echo "Skipping ${bundle} - already a single cert"
    continue
  fi

  echo "Unbundling ${bundle} (${cert_count} certs)..."

  python3 - <<EOF
import re, os

with open('${bundle}') as f:
    content = f.read()

certs = re.findall(r'-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----', content, re.DOTALL)

for i, cert in enumerate(certs):
    out_path = os.path.join('${CERTS_DIR}', '${bundle_name}-{:03d}.crt'.format(i))
    with open(out_path, 'w') as f:
        f.write(cert + '\n')
    print(f"  Wrote {out_path}")
EOF

  echo "Removing original bundle ${bundle}..."
  rm "$bundle"
done

echo "Done. Certs in ${CERTS_DIR}:"
ls -1 "${CERTS_DIR}"
