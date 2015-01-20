<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import com.levelup.palabre.provider.base.AbstractDataSource;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * AsyncDB Datasource for the {@code ${entity.nameLowerCase}} table.
</#if>
 */
public class ${entity.nameCamelCase}DataSource extends AbstractDataSource<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
    public ${entity.nameCamelCase}DataSource(@NonNull ContentResolver contentResolver, @NonNull ${entity.nameCamelCase}Serializer serializer) {
        this(contentResolver, new ${entity.nameCamelCase}ElementHandler(serializer));
    }

    public ${entity.nameCamelCase}DataSource(@NonNull Context context, @NonNull ${entity.nameCamelCase}Serializer serializer) {
        this(context, new ${entity.nameCamelCase}ElementHandler(serializer));
    }

    public ${entity.nameCamelCase}DataSource(@NonNull ContentResolver contentResolver, @NonNull ${entity.nameCamelCase}ElementHandler elementHandler) {
        super(contentResolver, ${entity.nameCamelCase}Columns.CONTENT_URI, elementHandler, elementHandler.serializer);
    }

    public ${entity.nameCamelCase}DataSource(@NonNull Context context, @NonNull ${entity.nameCamelCase}ElementHandler elementHandler) {
        super(context, ${entity.nameCamelCase}Columns.CONTENT_URI, elementHandler, elementHandler.serializer);
    }

    @Override
    public ${entity.nameCamelCase}Cursor wrapCursor(Cursor cursor) {
        return new ${entity.nameCamelCase}Cursor(cursor);
    }
}