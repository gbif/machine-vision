
# data used to translate the free text license in gbif to something useable

getLicenseData = function() {

licenseData = tibble::tribble(
  ~ "verbatimLicense", ~ "licenseVer", ~ "license", ~ "commercialUseAllowed", ~ "canOthersUse",
  "",NA,NA,FALSE,FALSE,
  "http://creativecommons.org/licenses/by/4.0/", "CC BY 4.0", "CC BY", TRUE, TRUE,
  "http://creativecommons.org/licenses/by-nc/4.0/", "CC BY-NC 4.0", "CC BY-NC", FALSE, TRUE,
  "http://creativecommons.org/licenses/by-nc-sa/3.0/", "CC BY-NC-SA 3.0", "CC BY-NC-SA",FALSE,TRUE,
  "http://creativecommons.org/licenses/by-nc-nd/4.0/", "CC BY-NC-ND 4.0", "CC BY-NC-ND",FALSE, FALSE,
  "http://creativecommons.org/licenses/by-sa/4.0/", "CC BY-SA 4.0", "CC BY-SA",FALSE, TRUE,
  "http://creativecommons.org/publicdomain/zero/1.0/", "CC0 1.0", "CC0",TRUE, TRUE,
  "http://creativecommons.org/licenses/by-nc/3.0/", "CC BY-NC 3.0", "CC BY-NC",FALSE, TRUE,
  "[Copyright] Field Museum of Natural History - CC BY-NC","CC BY-NC", "CC BY-NC",FALSE,TRUE,
  "http://creativecommons.org/licenses/by-nc-sa/4.0/", "CC BY-NC-SA", "CC BY-NC-SA",FALSE, TRUE,
  "Partial images provided by this server are released under the Creative Commons cc-by-sa 3.0 (generic) licence [http://creativecommons.org/licenses/by-sa/3.0/de/]. Please credit images to BGBM following our citation guidelines [http://ww2.bgbm.org/Herbarium/cite.cfm]. If you would like to use images in a format or resolution which is not provided here, please contact us (d.roepert[at]bgbm.org).", "CC BY-SA 3.0", "CC BY-SA",FALSE,TRUE,
  "All Rights Reserved", NA, NA,FALSE,FALSE,
  "[Copyright] The Field Museum", NA,NA,FALSE, FALSE,
  "Attribution-ShareAlike (BY-SA) Creative Commons License and GNU Free Documentation License (GFDL)", "CC BY-SA", "CC BY-SA",FALSE,TRUE,
  "http://creativecommons.org/licenses/by-nc-nd/3.0/", "CC BY-NC-ND", "CC BY-NC-ND",FALSE, FALSE,
  "All rights reserved", NA, NA, FALSE,FALSE,
  "(c) Field Museum of Natural History - CC BY-NC", "CC BY-NC", "CC BY-NC", FALSE,TRUE,
  "Images of the Herbarium Hamburgense (HBG) specimens are released under the Creative Commons CC-BY-SA 4.0 License [https://creativecommons.org/licenses/by-sa/4.0/].", "CC BY-SA 4.0", "CC BY-SA", FALSE, TRUE,
  "http://creativecommons.org/licenses/by-sa/3.0/", "CC BY-SA 3.0", "CC BY-SA", FALSE, TRUE,
  "(c) The Field Museum", NA, NA, FALSE, FALSE,
  "all rights reserved", NA, NA, FALSE, FALSE,
  "http://creativecommons.org/licenses/by/3.0/", "CC BY 3.0", "CC BY", TRUE, TRUE,
  "http://creativecommons.org/licenses/by-nc-nd/2.5/", "CC BY-NC-ND 2.5", "CC BY-NC-ND", FALSE, FALSE,
  "The person who associated a work with this deed has dedicated the work to the public domain by waiving all of his or her rights to the work worldwide under copyright law, including all related and neighboring rights, to the extent allowed by law.  You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.", "CC0 1.0", "CC0", TRUE, TRUE,
  "http://creativecommons.org/licenses/by-nd/4.0/", "CC BY-ND 4.0", "CC BY-ND", FALSE, FALSE,
  "If you want to use any images ask author for permission", NA, NA,FALSE,FALSE,
  "https://creativecommons.org/licenses/by/4.0/deed.en", "CC BY 4.0","CC BY", TRUE,TRUE,
  "CC BY-NC-SA 3.0 DE", "CC BY-NC-SA 3.0", "CC BY-NC-SA", FALSE, TRUE,
  "http://creativecommons.org/publicdomain/mark/1.0/", "CC0 1.0", "CC0", TRUE, TRUE,
  "CC-BY-SA-NC 3.0 Australia", "CC BY-SA-NC 3.0", "CC BY-SA-NC", FALSE, TRUE,
  "http://en.wikipedia.org/wiki/Copyright", NA, NA, FALSE, FALSE,
  "All photographs and content. Copyright 2003-2011 Gary Cobb and David Mullin", NA, NA, FALSE, FALSE,
  "Creative Commons Attribution Non-Commercial Australia 3.0", "CC NC 3.0", "CC NC", FALSE, TRUE,
  "Images provided are released under the Creative Commons CC BY-SA 4.0 licence [http://creativecommons.org/licenses/by-sa/4.0/]. Please credit images to BRM following our citation guideline: Bartsch, I. (ed.) 2006+: AWI-Herbarium Marine Macroalgae. Image Id. - Published at Alfred-Wegener-Institut, Helmholtz-Zentrum fuer Polar- und Meeresforschung.", "CC BY-SA 4.0", "CC BY-SA", FALSE, TRUE,
  "Permission to use media on MorphoSource granted by copyright holder", "CC0 1.0", "CC0",TRUE, TRUE,
  "Photo: MLSSA (Anne Wilson - Heterodontus portusjacksoni), mlssa.asn.au", NA, NA, FALSE, FALSE,
  "A&M. Kapitany, australiansucculents.com.au", NA, NA, FALSE, FALSE,
  "Australian Museum", NA, NA, FALSE, FALSE,
  "Photo: Bruce Thomson, http://www.auswildlife.com", NA, NA, FALSE, FALSE,
  "CreativeCommons", NA, NA, FALSE, FALSE,
  "? MESA", NA, NA, FALSE, FALSE,
  "https://creativecommons.org/licenses/by-nc/3.0/au/", "CC BY-NC 3.0", "CC BY-NC", FALSE, TRUE,
  "Copyright Richard Hartland", NA, NA, FALSE, FALSE,
  "Copyright permission not set", NA, NA, TRUE, TRUE,
  "http://...", NA, NA, FALSE, FALSE,
)

return(licenseData)
}

