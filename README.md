## Diabetes Data Analytics with SQL

This project explores and analyzes a real-world denormalized healthcare dataset on diabetic patient encounters. The data was cleaned, normalized into a relational structure, and analyzed using SQL to generate impactful healthcare insights.

#  Overview

- 📂 **Source:** A denormalized CSV file containing over 100,000 diabetic patient hospital encounters and 50+ attributes.
- 🧼 **Cleaned and Normalized:** Data was separated into **7 relational tables** (`patients`, `encounters`, `diagnoses`, `procedures`, `lab_results`, `medications`, `treatment_changes`) to remove redundancy and improve data integrity.
- 🧠 **Analyzed with SQL** using **SQLite**.
- 📊 **Insights generated:** From readmission patterns to racial disparities in treatment outcomes.

---

## ⚙️ Technologies Used

- **SQLite** for relational database management
- **SQL** for querying and analysis
- **DB Browser for SQLite** (optional GUI)

---

## 📁 Files

- `Diabetes.db (1).sql` – contains all SQL queries and documented insights
- [Optional CSV files] – for those wanting to recreate the database

---

## 📈 Key Insights

Here are some of the actionable insights derived from the analysis:

1. **📍 Unique Patients:** 73,426 individuals visited during the reporting period.
2. **♻️ Readmission Patterns:** Older patients and those on medication changes were more likely to be readmitted.
3. **🧬 Diagnosis Trends:** ICD code `428` was the most common primary diagnosis.
4. **💊 Polypharmacy Impact:** Patients taking >5 medications had higher readmission rates.
5. **🧪 Lab Testing & Readmission:** More lab tests were associated with higher likelihood of readmission — possibly due to patient severity.
6. **🧑‍⚕️ Specialties & Stay Duration:** Pediatrics - Allergy & Immunology had the longest average hospital stay.
7. **👥 Racial Disparities:** African American patients had longer average hospital stays.

---

## 🧠 Skills Demonstrated

- Data normalization & schema design
- Complex SQL joins and aggregations
- Insight extraction for healthcare decision-making
- Best practices in SQL project documentation

---

## 🚀 How to Use

1. Clone this repo
2. Open `Diabetes.db (1).sql` in any SQLite tool or CLI
3. Run queries to explore insights or modify for deeper analysis

---

## 📬 Contact

Feel free to reach out via [LinkedIn](https://www.linkedin.com/in/andrew-nwachimereze-okebugwu-mbbs-mph-phd-6b429617/)) or [email](mailto: dr.andrewokebugwu@gmail.com) for feedback, collaboration, or questions!

---

> "Data will talk if you're willing to listen." – Jim Bergeson
