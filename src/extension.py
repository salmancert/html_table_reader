# src/extension.py
import logging
import pandas as pd
import knime.extension as knext

LOGGER = logging.getLogger(__name__)

# Create category
my_category = knext.category(
    path="/community",
    level_id="html_readers",
    name="HTML Readers",
    description="Nodes for reading HTML content",
    icon="icon.png",
)

@knext.node(
    name="HTML Table Reader",
    node_type=knext.NodeType.SOURCE,
    icon_path="icon.png",
    category=my_category
)
@knext.output_table(
    name="Output Table",
    description="The extracted table data"
)
class HTMLTableReaderNode:
    """Simple HTML Table Reader Node"""
    
    file_path = knext.StringParameter(
        "File Path",
        "Path to the HTML/XLS file",
        ""
    )
    
    def configure(self, config_context):
        # Return a simple schema
        return knext.Schema([
            knext.Column(knext.string(), "column1"),
            knext.Column(knext.string(), "column2")
        ])
    
    def execute(self, exec_context):
        # Create simple test data
        df = pd.DataFrame({
            'column1': ['test1', 'test2'],
            'column2': ['value1', 'value2']
        })
        return knext.Table.from_pandas(df)
