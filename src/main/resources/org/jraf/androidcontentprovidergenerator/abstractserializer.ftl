<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import org.gawst.asyncdb.InvalidDbEntry;

import android.content.ContentValues;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Default Serializer class for the {@code ${entity.nameLowerCase}} table.
</#if>
<#if entity.hasContentProvider>
 * @see ${entity.nameCamelCase}ContentProviderDataSource#${entity.nameCamelCase}ContentProviderDataSource(android.content.Context, ${config.providerJavaPackage}.base.DatabaseSerializer)
 * @see ${entity.nameCamelCase}ContentProviderDataSource#${entity.nameCamelCase}ContentProviderDataSource(android.content.ContentResolver, ${config.providerJavaPackage}.base.DatabaseSerializer)
 </#if>
 * @see ${entity.nameCamelCase}SqliteDataSource#${entity.nameCamelCase}SqliteDataSource implements DatabaseSerializer(android.content.Context, ${config.providerJavaPackage}.base.DatabaseSerializer)
 */
public final class ${entity.nameCamelCase}DatabaseSerializer implements DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
    public static final ${entity.nameCamelCase}DatabaseSerializer INSTANCE = new ${entity.nameCamelCase}DatabaseSerializer();

    @NonNull
    @Override
    public ${entity.nameCamelCase}Model getValueFromCursor(${entity.nameCamelCase}Cursor cursor) throws InvalidDbEntry {
        return new ${entity.nameCamelCase}Impl.Builder(cursor).build();
    }

    @NonNull
    @Override
    public ContentValues getContentValuesFromData(@NonNull ${entity.nameCamelCase}Model data, boolean update) {
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues(data, update);
        return values.values();
    }
}