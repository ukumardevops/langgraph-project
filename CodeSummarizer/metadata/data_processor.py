import datetime

class DataProcessor:
    def __init__(self, records):
        self.records = records

    def filter_by_date(self, start_date, end_date):
        """Filter records between two dates."""
        filtered = []
        for record in self.records:
            record_date = datetime.datetime.strptime(record['date'], "%Y-%m-%d")
            if start_date <= record_date <= end_date:
                filtered.append(record)
        return filtered

    def compute_average(self, key):
        """Compute average of a numeric field."""
        total = 0
        count = 0
        for record in self.records:
            if key in record and isinstance(record[key], (int, float)):
                total += record[key]
                count += 1
        return total / count if count > 0 else None

    def tag_high_value(self, threshold):
        """Tag records with a 'high_value' flag."""
        for record in self.records:
            record['high_value'] = record.get('value', 0) > threshold
        return self.records
    
if __name__ == "__main__":
    sample_data = [
        {"date": "2023-01-10", "value": 120},
        {"date": "2023-02-15", "value": 80},
        {"date": "2023-03-20", "value": 150}
    ]

    processor = DataProcessor(sample_data)
    filtered = processor.filter_by_date(
        datetime.datetime(2023, 1, 1),
        datetime.datetime(2023, 2, 28)
    )
    avg = processor.compute_average("value")
    tagged = processor.tag_high_value(100)

    print("Filtered:", filtered)
    print("Average:", avg)
    print("Tagged:", tagged)